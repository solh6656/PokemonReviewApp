# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY ./ ./
WORKDIR /src

RUN dotnet restore
RUN dotnet publish -c Release -o /app

# Serve Stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS serve
WORKDIR /app
COPY --from=build /app .

EXPOSE 80

ENTRYPOINT [ "dotnet", "PokemonReviewApp.dll" ]
