FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["SampleApp/BackEnd/BackEnd.csproj", "SampleApp/BackEnd/"]
RUN dotnet restore "SampleApp/BackEnd/BackEnd.csproj"
COPY SampleApp/BackEnd/. SampleApp/BackEnd/
WORKDIR "/src/SampleApp/BackEnd"
RUN dotnet publish "BackEnd.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "BackEnd.dll"]
