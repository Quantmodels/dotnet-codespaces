FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app
EXPOSE 8081
ENV ASPNETCORE_URLS=http://+:8081
ENV WEATHER_URL=http://backend:8080

FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY ["SampleApp/FrontEnd/FrontEnd.csproj", "SampleApp/FrontEnd/"]
RUN dotnet restore "SampleApp/FrontEnd/FrontEnd.csproj"
COPY SampleApp/FrontEnd/. SampleApp/FrontEnd/
WORKDIR "/src/SampleApp/FrontEnd"
RUN dotnet publish "FrontEnd.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "FrontEnd.dll"]
