# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy everything from the context (api-gateway folder)
COPY . .

# Restore and publish the API Gateway
RUN dotnet restore "iAssist.ApiGateway/iAssist.ApiGateway.csproj"
RUN dotnet publish "iAssist.ApiGateway/iAssist.ApiGateway.csproj" -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "iAssist.ApiGateway.dll"]