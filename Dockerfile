FROM mcr.microsoft.com/dotnet/core/sdk:3.0-alpine AS restore
WORKDIR /tmp/build
COPY . .
RUN dotnet restore 

FROM restore AS build
WORKDIR /tmp/build
COPY . .
RUN dotnet publish -o output restore-example.csproj

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-alpine AS runtime
WORKDIR /app
COPY --from=build /tmp/build/output .
ENTRYPOINT [ "dotnet", "restore-example.dll"]