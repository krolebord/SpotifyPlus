using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using SpotifyPlus.Filters;
using SpotifyPlus.Models.Spotify;
using SpotifyPlus.Services;

namespace SpotifyPlus.Controllers
{
    [ApiController]
    [Route("auth")]
    [ServiceFilter(typeof(LogRequestsFilter))]
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
        public async Task<ActionResult> AuthCallback(
            [FromQuery(Name = "state")] string? authKey = null,
            [FromQuery] string? code = null,
            [FromQuery] string? error = null)
        {
            var redirect = Redirect("https://spotify.com");

            if (string.IsNullOrWhiteSpace(authKey))
                return redirect;

            if (!string.IsNullOrWhiteSpace(error))
            {
                _authManager.HandleAuthCallbackError(error, authKey);
                return redirect;
            }

            if (!string.IsNullOrWhiteSpace(code))
                await _authManager.HandleAuthCallback(code, authKey);


            return redirect;
        }

        [HttpGet("{authKey}")]
        public async Task<ActionResult<AuthData>> GetAuthData([FromRoute] string authKey)
        {
            if (string.IsNullOrWhiteSpace(authKey))
                return NotFound();

            var result = await _authManager.GetAuthDataFromAuthKey(authKey);

            return result.Match<ActionResult>(
                authData => Ok(authData),
                error => BadRequest(error.Message)
            );
        }

        [HttpGet("refresh")]
        public async Task<ActionResult<AuthData>> RefreshAuthData([FromQuery] string refreshToken)
        {
            if (string.IsNullOrWhiteSpace(refreshToken))
                return BadRequest();

            var result = await _authManager.GetAuthDataFromRefreshToken(refreshToken);

            return result.Match<ActionResult>(
                authData => Ok(authData),
                error => BadRequest(error.Message)
            );
        }
    }
}
