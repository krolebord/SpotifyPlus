using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Logging;

namespace SpotifyPlus.Filters
{
    public class LogRequestsFilter : IAsyncActionFilter
    {
        private readonly ILogger<LogRequestsFilter> _logger;

        public LogRequestsFilter(ILogger<LogRequestsFilter> logger)
        {
            _logger = logger;
        }

        public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
        {
            _logger.LogInformation("Processing request to action: {Action}", context.ActionDescriptor.DisplayName);
            await next();
        }
    }
}
