# Use the official .NET SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file(s) and restore dependencies
COPY iAssist.ApiGateway/iAssist.ApiGateway.csproj ./iAssist.ApiGateway/
RUN dotnet restore "./iAssist.ApiGateway/iAssist.ApiGateway.csproj"

# Copy the rest of the source code
COPY . .

# Build and publish the app
WORKDIR /src/iAssist.ApiGateway
RUN dotnet publish -c Release -o /app/publish

# Use a smaller runtime image for final output
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "iAssist.ApiGateway.dll"]
