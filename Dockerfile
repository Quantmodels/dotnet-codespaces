FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["SampleApp/BackEnd/BackEnd.csproj", "SampleApp/BackEnd/"]
COPY ["SampleApp/FrontEnd/FrontEnd.csproj", "SampleApp/FrontEnd/"]
RUN dotnet restore "SampleApp/BackEnd/BackEnd.csproj" \
    && dotnet restore "SampleApp/FrontEnd/FrontEnd.csproj"

COPY SampleApp/BackEnd/. SampleApp/BackEnd/
COPY SampleApp/FrontEnd/. SampleApp/FrontEnd/

RUN dotnet publish "SampleApp/BackEnd/BackEnd.csproj" \
    -c Release -o /app/backend /p:UseAppHost=false \
    && dotnet publish "SampleApp/FrontEnd/FrontEnd.csproj" \
    -c Release -o /app/frontend /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

COPY --from=build /app/backend /app/backend
COPY --from=build /app/frontend /app/frontend
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true
EXPOSE 10000

ENTRYPOINT ["/app/start.sh"]
