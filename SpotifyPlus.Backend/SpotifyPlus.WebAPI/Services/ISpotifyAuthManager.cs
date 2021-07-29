using System.Collections.Concurrent;
using System.Threading.Tasks;
using OneOf;
using OneOf.Types;
using SpotifyPlus.Errors;
using SpotifyPlus.Models.Spotify;

namespace SpotifyPlus.Services
{
    public interface ISpotifyAuthManager
    {
        public OneOf<AuthSession, AuthManagerError> StartAuthSession();

        public Task<OneOf<Success, AuthManagerError>> HandleAuthCallback(string code, string authKey);

        public OneOf<Success, AuthManagerError> HandleAuthCallbackError(string error, string authKey);

        public Task<OneOf<AuthData, AuthManagerError>> GetAuthDataFromAuthKey(string authKey);

        public Task<OneOf<AuthData, AuthManagerError>> GetAuthDataFromRefreshToken(string refreshToken);
    }
}
