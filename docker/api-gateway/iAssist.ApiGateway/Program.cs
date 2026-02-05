using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System.Reflection;
using System.IO;

var builder = WebApplication.CreateBuilder(args);

// Register controllers and Swagger
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// =======================================================
// Dynamic Intelligence Gateway Loader
// =======================================================

// Detect whether the private intelligence repo is mounted or enabled
bool privateMode = false;

// Path to private repo relative to this project
string privatePath = Path.Combine(AppContext.BaseDirectory, "../../../../../iAssist-intelligence/intelligence");

if (Directory.Exists(privatePath) || Environment.GetEnvironmentVariable("USE_PRIVATE_INTELLIGENCE") == "true")
{
    privateMode = true;
    Console.WriteLine("Private Intelligence detected — loading advanced services...");

    try
    {
        string assemblyPath = Path.Combine(privatePath, "bin", "Release", "net8.0", "iAssist.Intelligence.dll");

        if (File.Exists(assemblyPath))
        {
            var asm = Assembly.LoadFrom(assemblyPath);
            var serviceTypes = asm.GetTypes()
                .Where(t => t.Name.EndsWith("Service") && !t.IsInterface && !t.IsAbstract);

            foreach (var serviceType in serviceTypes)
            {
                var iface = serviceType.GetInterfaces().FirstOrDefault();
                if (iface != null)
                {
                    builder.Services.AddScoped(iface, serviceType);
                    Console.WriteLine($"Registered private service: {iface.Name} → {serviceType.Name}");
                }
            }
        }
        else
        {
            Console.WriteLine( "No compiled intelligence assembly found. Run `dotnet build` in iAssist-intelligence.");
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Error loading intelligence assembly: {ex.Message}");
    }
}
else
{
    Console.WriteLine("Running in Public mode — using mock/stub services.");

    // Register lightweight mock services
    builder.Services.AddScoped<IDatabaseService, MockDatabaseService>();
    builder.Services.AddScoped<ITrainingService, MockTrainingService>();
}

// =======================================================
// Build and Configure Application
// =======================================================

var app = builder.Build();

// Swagger always available for testing/documentation
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "iAssist API Gateway v1");
    c.RoutePrefix = "swagger"; // UI at /swagger
});

app.UseRouting();
app.UseAuthorization();

// Default root endpoint for browser access
app.MapGet("/", () =>
    Results.Json(new
    {
        status = "iAssist API Gateway is running",
        mode = privateMode ? "Private Intelligence Active" : "Public Mode",
        version = "1.0.0",
        environment = app.Environment.EnvironmentName,
        time = DateTime.UtcNow
    })
);

// Health endpoint for manager script
app.MapGet("/health", () =>
    Results.Json(new
    {
        status = "healthy",
        service = "api-gateway",
        mode = privateMode ? "private" : "public",
        time = DateTime.UtcNow
    })
);

app.MapControllers();
app.Run();

// =======================================================
// Mock service interfaces and implementations (Public Mode)
// =======================================================

public interface IDatabaseService
{
    string GetStatus();
}

public class MockDatabaseService : IDatabaseService
{
    public string GetStatus() => "Mock database service active (public mode).";
}

public interface ITrainingService
{
    string Train();
}

public class MockTrainingService : ITrainingService
{
    public string Train() => "Mock training service active (no private logic).";
}
