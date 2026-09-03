@echo off
title GTNH 2.9.0-beta-1 Server
cd /d "%~dp0"

echo ============================================================
echo   GT: New Horizons 2.9.0-beta-1 - Server Launcher
echo.
echo   FIRST START will take about 5-10 minutes (mod loading +
echo   world generation). Be patient.
echo   The server is READY when the console shows a line with:
echo       Done (...)!
echo.
echo   To stop the server later: type  stop  and press Enter.
echo   (Do not just close the window - the world may get damaged.)
echo ============================================================
echo.

"C:\Users\mushroom\.devtools\jdk17\jdk-17.0.20.1+1\bin\java.exe" -Xms6G -Xmx6G -Dfml.readTimeout=180 @java9args.txt -jar lwjgl3ify-forgePatches.jar nogui

echo.
echo Server process exited (errorlevel=%errorlevel%).
echo Press any key to close this window.
pause
