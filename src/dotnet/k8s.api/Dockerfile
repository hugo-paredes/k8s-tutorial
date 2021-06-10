FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY k8s.api.csproj .
RUN dotnet restore k8s.api.csproj
COPY . .
WORKDIR /src
RUN dotnet build "k8s.api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "/src/k8s.api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "k8s.api.dll"]
