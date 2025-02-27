FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY ./ ./
WORKDIR /src

CMD [ "dotnet","restore" ]
RUN dotnet publish -c Release -o PokemonReviewApp

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS serve
WORKDIR /app
COPY --from=build /src/PokemonReviewApp .

EXPOSE 8080

ENTRYPOINT [ "dotnet", "PokemonReviewApp.dll" ]
