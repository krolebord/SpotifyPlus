using System;

namespace SpotifyPlus.Models.Spotify
{
    public class AuthSession
    {
        public string AuthUrl { get; }

        public string AuthKey { get; }

        public DateTimeOffset ExpiresAt { get; }

        public AuthSession(string authUrl, string authKey, DateTimeOffset expiresAt)
        {
            AuthUrl = authUrl;
            AuthKey = authKey;
            ExpiresAt = expiresAt;
        }
    }
}
