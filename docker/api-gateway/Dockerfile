# ===================== BUILD STAGE =====================
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy everything and build
COPY . .
RUN dotnet restore "iAssist.ApiGateway/iAssist.ApiGateway.csproj"
RUN dotnet publish "iAssist.ApiGateway/iAssist.ApiGateway.csproj" -c Release -o /app/publish

# ===================== RUNTIME STAGE =====================
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .
EXPOSE 8080

# Make sure the entry point points to your DLL name
ENTRYPOINT ["dotnet", "iAssist.ApiGateway.dll"]
