@echo off
title Discord-to-Discord Forwarder Leaks - RUNNING
color 0A
cls

REM Change to the correct directory
cd /d "C:\Users\mpmmo\discord-forwarder-production"

REM Archive old log if it exists and is large
if exist discord_to_discord_forwarder_leaks.log (
    echo Archiving previous log...
    move /Y discord_to_discord_forwarder_leaks.log discord_to_discord_forwarder_leaks_old.log >nul 2>&1
)

echo =========================================
echo    DISCORD-TO-DISCORD FORWARDER (LEAKS) - PRODUCTION
echo =========================================
echo.
echo Starting forwarder...
echo Press Ctrl+C to stop
echo.
echo =========================================
echo.

REM Check Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo ERROR: Python not found!
    echo Please install Python first.
    pause
    exit /b 1
)

REM Install requirements if needed
pip show aiohttp >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing required packages...
    pip install aiohttp
)

REM Run the forwarder
python discord_to_discord_forwarder_leaks.py

REM If it crashes, show error
if %errorlevel% neq 0 (
    color 0C
    echo.
    echo =========================================
    echo    ERROR: Forwarder crashed!
    echo    Check discord_to_discord_forwarder_leaks.log for details
    echo =========================================
    pause
)

pause