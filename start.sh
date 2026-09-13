#!/bin/sh
set -eu

: "${PORT:=10000}"

ASPNETCORE_URLS=http://127.0.0.1:8080 dotnet /app/backend/BackEnd.dll &
backend_pid=$!

cleanup() {
    kill "$backend_pid" 2>/dev/null || true
}

trap cleanup INT TERM EXIT

WEATHER_URL=http://127.0.0.1:8080 ASPNETCORE_URLS="http://+:${PORT}" dotnet /app/frontend/FrontEnd.dll &
frontend_pid=$!

wait "$frontend_pid"
