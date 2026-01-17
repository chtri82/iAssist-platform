using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using System.Net.Http;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

HttpClient client = new HttpClient();

app.MapGet("/", () => "iAssist API Gateway operational.");
app.MapGet("/ai/motivate", async () =>
{
    var response = await client.GetStringAsync("http://ai-core:5000/motivate");
    return Results.Content(response, "application/json");
});

app.Run("http://0.0.0.0:8080");
