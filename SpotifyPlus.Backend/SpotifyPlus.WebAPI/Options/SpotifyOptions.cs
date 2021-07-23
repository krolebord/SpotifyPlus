namespace SpotifyPlus.Options
{
    public class SpotifyOptions
    {
        public const string Key = "SpotifyOptions";

        public string ClientId { get; set; } = string.Empty;

        public string ClientSecret { get; set; } = string.Empty;

        public string RedirectUrl { get; set; } = string.Empty;

        public int SessionDuration { get; set; }
    }
}
