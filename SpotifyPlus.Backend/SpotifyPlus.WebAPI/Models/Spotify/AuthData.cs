using System;
using System.Collections.Generic;

namespace SpotifyPlus.Models.Spotify
{
    public class AuthData
    {
        public string AccessToken { get; init; } = string.Empty;

        public string RefreshToken { get; init; } = string.Empty;

        public List<string> Scopes { get; init; } = new();

        public DateTimeOffset ExpiresAt { get; init; }
    }
}
