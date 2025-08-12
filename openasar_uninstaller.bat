@echo off
setlocal enabledelayedexpansion

echo This will restore original Discord files from any existing backups.
echo No new backups will be created.
pause

set "discordBaseDir=%localappdata%\Discord"
set "found=0"

for /d %%i in ("%discordBaseDir%\app-*") do (
  if exist "%%i\resources\app.asar.backup" set "found=1"
  if exist "%%i\resources\_app.asar.backup" set "found=1"
  if exist "%%i\resources\app.asar.orig.backup" set "found=1"
)

if "%found%"=="0" (
  echo.
  echo No OpenAsar backup files detected — nothing to uninstall.
  echo If you manually renamed files, this script will not modify them.
  pause
  exit /b 0
)

echo.
echo Backups detected. Closing Discord...
C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul
C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul
C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul
C:\Windows\System32\TIMEOUT.exe /t 5 /nobreak > nul 2> nul

for /d %%i in ("%discordBaseDir%\app-*") do (
  if exist "%%i\resources\app.asar.backup" (
    echo Restoring: %%i\resources\app.asar
    move /y "%%i\resources\app.asar.backup" "%%i\resources\app.asar" > nul 2> nul
  )
  if exist "%%i\resources\_app.asar.backup" (
    echo Restoring: %%i\resources\_app.asar
    move /y "%%i\resources\_app.asar.backup" "%%i\resources\_app.asar" > nul 2> nul
  )
  if exist "%%i\resources\app.asar.orig.backup" (
    echo Restoring: %%i\resources\app.asar.orig
    move /y "%%i\resources\app.asar.orig.backup" "%%i\resources\app.asar.orig" > nul 2> nul
  )
)

echo.
echo Starting Discord...
start "" "%localappdata%\Discord\Update.exe" --processStart Discord.exe > nul 2> nul
C:\Windows\System32\TIMEOUT.exe /t 1 /nobreak > nul 2> nul

echo.
echo Restore complete.
pause