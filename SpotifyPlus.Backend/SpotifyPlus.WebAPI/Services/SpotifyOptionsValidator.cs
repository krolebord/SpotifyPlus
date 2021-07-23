using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SpotifyPlus.Options;

namespace SpotifyPlus.Services
{
    public class SpotifyOptionsValidator : ISpotifyOptionsValidator
    {
        private readonly ILogger<SpotifyOptionsValidator> _logger;
        private readonly SpotifyOptions _spotifyOptions;

        public SpotifyOptionsValidator(ILogger<SpotifyOptionsValidator> logger, IOptions<SpotifyOptions> spotifyOptions)
        {
            _logger = logger;
            _spotifyOptions = spotifyOptions.Value;
        }

        public void LogValidation()
        {
            if(!ValidateOptions())
                _logger.LogCritical("Spotify ClientSecret is invalid\nPlease set valid ClientSecret in environment variables");
            else
                _logger.LogInformation("Spotify ClientSecret seems valid");
        }

        private bool ValidateOptions()
        {
            return !string.IsNullOrWhiteSpace(_spotifyOptions.ClientSecret) && _spotifyOptions.ClientSecret != "SET_CLIENT_SECRET_HERE";
        }
    }
}
