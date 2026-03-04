@echo off
setlocal EnableDelayedExpansion

set "BASE_DIR=%~dp0"
set "PORT=8000"
set "TARGET=sichuan_adv.html"
set "WEB_DIR=%BASE_DIR%"
set "REL_PATH=%TARGET%"

if not exist "%WEB_DIR%%REL_PATH%" (
  echo [ERROR] Cannot find "%TARGET%" under "%BASE_DIR%"
  pause
  exit /b 1
)

cd /d "%WEB_DIR%"

echo Starting local server in "%WEB_DIR%" ...

where py >nul 2>nul
if %errorlevel%==0 (
  start "Sichuan Server" cmd /k "py -3 -m http.server %PORT%"
) else (
  where python >nul 2>nul
  if %errorlevel%==0 (
    start "Sichuan Server" cmd /k "python -m http.server %PORT%"
  ) else (
    echo [ERROR] Python is not installed or not in PATH.
    echo Install Python and try again.
    pause
    exit /b 1
  )
)

timeout /t 2 /nobreak >nul
set "CACHE_BUSTER=%RANDOM%%RANDOM%%RANDOM%"
set "URL=http://localhost:%PORT%/%REL_PATH%?v=%CACHE_BUSTER%"
set "URL=%URL:\=/%"
start "" "%URL%"

echo Opened: %URL%
echo Keep the server window open while playing.
exit /b 0
