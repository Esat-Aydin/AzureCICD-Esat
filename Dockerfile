FROM mcr.microsoft.com/dotnet/sdk:7.0 as build-env
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/sdk:7.0
WORKDIR / app
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "ci-cd-api.dll" ]