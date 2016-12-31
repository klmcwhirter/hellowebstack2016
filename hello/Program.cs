using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;

namespace hello
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var config = new ConfigurationBuilder()
                .AddCommandLine(args)
                .AddEnvironmentVariables(prefix: "ASPNETCORE_")
                .Build();

            var hostBuilder = new WebHostBuilder()
                .UseConfiguration(config)
                .UseKestrel()
                .UseContentRoot(Directory.GetCurrentDirectory())
                .UseIISIntegration()
                .UseStartup<Startup>()
                .UseUrls("http://*:5000/");

            if(Environment.GetEnvironmentVariable("HELLODOCKER") == null)
            {
                var distPath = Path.Combine(Directory.GetCurrentDirectory(), "dist");
                hostBuilder
                    .UseContentRoot(Path.Combine(distPath))
                    .UseWebRoot(Path.Combine(distPath));
            }

            var host = hostBuilder
                .UseStartup<Startup>()
                .Build();

            host.Run();
        }
    }
}
