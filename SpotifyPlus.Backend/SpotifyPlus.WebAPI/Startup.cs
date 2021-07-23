using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json;
using SpotifyPlus.Options;
using SpotifyPlus.Services;

namespace SpotifyPlus
{
    public class Startup
    {
        private readonly IWebHostEnvironment _environment;
        private IConfiguration _configuration;

        public Startup(IWebHostEnvironment environment, IConfiguration configuration)
        {
            _environment = environment;
            _configuration = configuration;
        }

        public void ConfigureServices(IServiceCollection services)
        {
            _configuration = new ConfigurationBuilder()
                .AddConfiguration(_configuration)
                .AddJsonFile("appsecrets.json")
                .Build();

            services.AddSingleton(_configuration);

            services.AddOptions<SpotifyOptions>().BindConfiguration(SpotifyOptions.Key);

            services.AddSingleton<ISpotifyAuthManager, SpotifyAuthManager>();

            services.AddCors();

            services.AddControllers()
                .AddNewtonsoftJson(options =>
                {
                    options.SerializerSettings.Formatting =
                        _environment.IsDevelopment() ? Formatting.Indented : Formatting.None;
                });

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo {Title = "SpotifyPlus", Version = "v1"});
            });
        }

        public void Configure(IApplicationBuilder app)
        {
            if (_environment.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "SpotifyPlus v1"));
            }

            app.UseHttpsRedirection();

            app.UseCors(policyBuilder => policyBuilder
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader());

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
        }
    }
}