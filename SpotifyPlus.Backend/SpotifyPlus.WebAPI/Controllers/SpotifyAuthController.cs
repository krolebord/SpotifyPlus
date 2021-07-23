using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using SpotifyPlus.Models.Spotify;
using SpotifyPlus.Services;

namespace SpotifyPlus.Controllers
{
    [ApiController]
    [Route("auth")]
    public class SpotifyAuthController : ControllerBase
    {
        private readonly ISpotifyAuthManager _authManager;

        public SpotifyAuthController(ISpotifyAuthManager authManager)
        {
            _authManager = authManager;
        }

        [HttpGet]
        public ActionResult<AuthSession> StartAuthSession()
        {
            var result = _authManager.StartAuthSession();

            return result.Match<ActionResult<AuthSession>>(
                authSession => Ok(authSession),
                error => BadRequest(error.Message)
            );
        }

        [HttpGet("callback")]
        public async Task<ActionResult> AuthCallback([FromQuery] string code, [FromQuery(Name = "state")] string authKey)
        {
            if (string.IsNullOrWhiteSpace(code))
                return BadRequest("Invalid code");

            await _authManager.HandleAuthCallback(code, authKey);

            return Redirect("https://spotify.com");
        }

        [HttpGet("{authKey}")]
        public async Task<ActionResult<AuthData>> GetAuthData([FromRoute] string authKey)
        {
            if (string.IsNullOrWhiteSpace(authKey))
                return NotFound();

            var result = await _authManager.GetAuthData(authKey);

            return result.Match<ActionResult>(
                authData => Ok(authData),
                error => BadRequest(error.Message)
            );
        }
    }
}
