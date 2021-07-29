using System;
using System.Text;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.Extensions.Options;
using SpotifyPlus.Models.Spotify;
using OneOf;
using OneOf.Types;
using SpotifyPlus.Errors;
using SpotifyPlus.Exceptions;
using SpotifyPlus.Options;

namespace SpotifyPlus.Services
{
    public class SpotifyAuthManager : ISpotifyAuthManager
    {
        private static readonly List<string> AuthScopes = new()
        {
            "user-read-private",
            "user-read-email",
            "user-library-read",
            "user-read-currently-playing",
            "user-modify-playback-state",
            "user-top-read"
        };

        private readonly SpotifyOptions _spotifyOptions;

        private readonly ConcurrentDictionary<string, TaskCompletionSource<OneOf<AuthData, AuthTimeout, AuthCanceled>>> _authSessions = new();

        public SpotifyAuthManager(IOptions<SpotifyOptions> spotifyOptions)
        {
            _spotifyOptions = spotifyOptions.Value;
        }

        public OneOf<AuthSession, AuthManagerError> StartAuthSession()
        {
            string authKey = Guid.NewGuid().ToString();
            TaskCompletionSource<OneOf<AuthData, AuthTimeout, AuthCanceled>> task = new();

            if (!_authSessions.TryAdd(authKey, task))
                return new AuthManagerError("Couldn't start auth session");

            var expireDuration = TimeSpan.FromSeconds(_spotifyOptions.SessionDuration);

            Task.Delay(expireDuration)
                .ContinueWith(_ => CloseAuthSession(authKey));

            QueryBuilder queryBuilder = new()
            {
                {"response_type", "code"},
                {"client_id", _spotifyOptions.ClientId},
                {"scope", string.Join(' ', AuthScopes) },
                {"redirect_uri", _spotifyOptions.RedirectUrl},
                {"show_dialog", "true"},
                {"state", authKey}
            };

            return new AuthSession(
                SpotifyApiUrls.Authorize + queryBuilder,
                authKey,
                DateTimeOffset.Now.Add(expireDuration)
            );
        }

        private void CloseAuthSession(string authKey)
        {
            if(!ValidateKey(authKey))
                return;

            if (!_authSessions.TryRemove(authKey, out var task))
                throw new AuthManagerException($"Couldn't close auth session. Auth key={authKey}");

            task.TrySetResult(new AuthTimeout());
        }

        public async Task<OneOf<Success, AuthManagerError>> HandleAuthCallback(string code, string authKey)
        {
            if (!ValidateKey(authKey))
                return new AuthManagerError("Auth session key is invalid");

            var authTask = _authSessions[authKey];

            var authResult = await GetAuthData(code);

            if(authResult.IsT0)
                authTask.SetResult(authResult.AsT0);

            return authResult.Match<OneOf<Success, AuthManagerError>>(
                authData => new Success(),
                error => error
            );
        }

        public OneOf<Success, AuthManagerError> HandleAuthCallbackError(string error, string authKey)
        {
            if (!ValidateKey(authKey))
                return new AuthManagerError("Auth session key is invalid");

            var authTask = _authSessions[authKey];
            authTask.SetResult(new AuthCanceled());

            return new Success();
        }

        public async Task<OneOf<AuthData, AuthManagerError>> GetAuthDataFromAuthKey(string authKey)
        {
            if(!ValidateKey(authKey))
                return new AuthManagerError("Auth session key is invalid");

            var sessionResult = await _authSessions[authKey].Task;

            return sessionResult.Match<OneOf<AuthData, AuthManagerError>>(
                authData => authData,
                timeout => new AuthManagerError("Auth session expired"),
                error => new AuthManagerError("Auth session canceled")
            );
        }

        public async Task<OneOf<AuthData, AuthManagerError>> GetAuthDataFromRefreshToken(string refreshToken)
        {
            return await GetAuthData(refreshToken, isRefresh: true);
        }

        private async Task<OneOf<AuthData, AuthManagerError>> GetAuthData(string code, bool isRefresh = false)
        {
            var authStart = DateTimeOffset.Now;

            using HttpClient client = new();

            var bearer = GetEncodedToken();

            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", bearer);

            var formContent = isRefresh
                ? new FormUrlEncodedContent(new KeyValuePair<string?, string?>[]
                {
                    new("refresh_token", code),
                    new("grant_type", "refresh_token"),
                })
                : new FormUrlEncodedContent(new KeyValuePair<string?, string?>[]
                {
                    new("code", code),
                    new("redirect_uri", _spotifyOptions.RedirectUrl),
                    new("grant_type", "authorization_code"),
                });

            var authResponse = await client.PostAsync(SpotifyApiUrls.Token, formContent);

            var authTokens = await authResponse.Content.ReadFromJsonAsync<AuthTokens>();

            if (authTokens == null)
                return new AuthManagerError("Couldn't retrieve auth data");

            return new AuthData
            {
                AccessToken = authTokens.AccessToken,
                RefreshToken = authTokens.RefreshToken,
                Scopes = authTokens.Scope.Split(' ').ToList(),
                ExpiresAt = authStart.AddSeconds(authTokens.ExpiresIn)
            };
        }

        private bool ValidateKey(string authKey)
        {
            return _authSessions.ContainsKey(authKey);
        }

        private string GetEncodedToken()
        {
            return Convert.ToBase64String(
                Encoding.ASCII.GetBytes(_spotifyOptions.ClientId + ':' + _spotifyOptions.ClientSecret));
        }
    }
}
