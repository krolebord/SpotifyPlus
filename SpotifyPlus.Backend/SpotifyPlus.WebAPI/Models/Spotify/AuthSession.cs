using System;

namespace SpotifyPlus.Models.Spotify
{
    public class AuthSession
    {
        public string AuthUrl { get; }

        public string TokenUrl { get; }

        public string AuthKey { get; }

        public DateTimeOffset ExpiresAt { get; }

        public AuthSession(string authUrl, string tokenUrl, string authKey, DateTimeOffset expiresAt)
        {
            AuthUrl = authUrl;
            TokenUrl = tokenUrl;
            AuthKey = authKey;
            ExpiresAt = expiresAt;
        }
    }
}
