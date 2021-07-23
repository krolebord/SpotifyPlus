using System;
using System.Text;
using System.Collections.Concurrent;
using System.Collections.Generic;
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
        private readonly SpotifyOptions _spotifyOptions;

        private readonly ConcurrentDictionary<string, TaskCompletionSource<OneOf<AuthData, AuthTimeout>>> _authSessions = new();

        public SpotifyAuthManager(IOptions<SpotifyOptions> spotifyOptions)
        {
            _spotifyOptions = spotifyOptions.Value;
        }

        public OneOf<AuthSession, AuthManagerError> StartAuthSession()
        {
            string authKey = Guid.NewGuid().ToString();
            TaskCompletionSource<OneOf<AuthData, AuthTimeout>> task = new();

            if (!_authSessions.TryAdd(authKey, task))
                return new AuthManagerError("Couldn't start auth session");

            var expireDuration = TimeSpan.FromSeconds(_spotifyOptions.SessionDuration);

            Task.Delay(expireDuration)
                .ContinueWith(_ => CloseAuthSession(authKey));

            QueryBuilder queryBuilder = new()
            {
                {"response_type", "code"},
                {"client_id", _spotifyOptions.ClientId},
                {"scope", "user-read-private user-read-email user-library-read user-read-currently-playing"},
                {"redirect_uri", _spotifyOptions.RedirectUrl},
                {"show_dialog", "true"},
                {"state", authKey}
            };

            return new AuthSession(
                SpotifyApiUrls.Authorize + queryBuilder,
                ApiUrls.FullApiUrl + $"/auth/{authKey}",
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

            using HttpClient client = new();

            var bearer = GetEncodedToken();

            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", bearer);

            var formData = new KeyValuePair<string?, string?>[]
            {
                new("code", code),
                new("redirect_uri", _spotifyOptions.RedirectUrl),
                new("grant_type", "authorization_code"),
            };

            var formContent = new FormUrlEncodedContent(formData);

            var authResponse = await client.PostAsync(SpotifyApiUrls.Token, formContent);

            var authData = await authResponse.Content.ReadFromJsonAsync<AuthData>();

            if (authData == null)
                return new AuthManagerError("Couldn't retrieve auth data");

            authTask.SetResult(authData);
            return new Success();
        }

        public async Task<OneOf<AuthData, AuthManagerError>> GetAuthData(string authKey)
        {
            if(!ValidateKey(authKey))
                return new AuthManagerError("Auth session key is invalid");

            var sessionResult = await _authSessions[authKey].Task;

            return sessionResult.Match<OneOf<AuthData, AuthManagerError>>(
                authData => authData,
                timeout => new AuthManagerError("Auth session expired")
            );
        }

        public bool ValidateKey(string authKey)
        {
            return _authSessions.ContainsKey(authKey);
        }

        private string GetEncodedToken()
        {
            return Convert.ToBase64String(
                Encoding.ASCII.GetBytes(_spotifyOptions.ClientId + ":" + _spotifyOptions.ClientSecret));
        }
    }
}
