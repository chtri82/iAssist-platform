using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);

// ✅ Register controllers and Swagger
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// ✅ Enable Swagger (even outside Development)
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "iAssist API Gateway v1");
    c.RoutePrefix = "swagger"; // UI at /swagger
});

app.UseRouting();
app.UseAuthorization();

// ✅ Default root endpoint for browser access
app.MapGet("/", () =>
    Results.Json(new
    {
        status = "iAssist API Gateway is running",
        version = "1.0.0",
        environment = app.Environment.EnvironmentName,
        time = DateTime.UtcNow
    })
);

// ✅ Health endpoint for manager script
app.MapGet("/health", () =>
    Results.Json(new
    {
        status = "healthy",
        service = "api-gateway",
        time = DateTime.UtcNow
    })
);

app.MapControllers();
app.Run();
