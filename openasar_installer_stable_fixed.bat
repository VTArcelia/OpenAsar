@echo off
echo Uninstall OpenAsar if you already have it installed by going to %Localappdata%/Discord/app-*/
echo Delete the 39KB app.asar and rename the app.asar.backup (around 9000KB) to just app.asar if reverting
echo This script now avoids overwriting any *.backup files if they already exist.
pause

echo Closing Discord... (wait around 5 seconds)

C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul
C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul
C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul

C:\Windows\System32\TIMEOUT.exe /t 5 /nobreak > nul 2> nul

echo Installing OpenAsar... (ignore any blue output flashes)

set "discordBaseDir=%localappdata%\Discord"

for /d %%i in ("%discordBaseDir%\app-*") do (
    if exist "%%i\resources\app.asar" (
        echo Processing: %%i

        if not exist "%%i\resources\app.asar.backup" (
            copy /y "%%i\resources\app.asar" "%%i\resources\app.asar.backup" > nul 2> nul
            echo Created backup: app.asar.backup
        )

        if exist "%%i\resources\_app.asar" (
            if not exist "%%i\resources\_app.asar.backup" (
                copy /y "%%i\resources\_app.asar" "%%i\resources\_app.asar.backup" > nul 2> nul
                echo Created backup: _app.asar.backup
            )
        )

        if exist "%%i\resources\app.asar.orig" (
            if not exist "%%i\resources\app.asar.orig.backup" (
                copy /y "%%i\resources\app.asar.orig" "%%i\resources\app.asar.orig.backup" > nul 2> nul
                echo Created backup: app.asar.orig.backup
            )
        )

        powershell -Command "Invoke-WebRequest https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar -OutFile \"%%i\resources\app.asar\"" > nul 2> nul

        if exist "%%i\resources\_app.asar" (
            powershell -Command "Invoke-WebRequest https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar -OutFile \"%%i\resources\_app.asar\"" > nul 2> nul
        )

        if exist "%%i\resources\app.asar.orig" (
            powershell -Command "Invoke-WebRequest https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar -OutFile \"%%i\resources\app.asar.orig\"" > nul 2> nul
        )
    )
)

echo Opening Discord...
start "" "%localappdata%\Discord\Update.exe" --processStart Discord.exe > nul 2> nul

C:\Windows\System32\TIMEOUT.exe /t 1 /nobreak > nul 2> nul

echo.
echo.
echo OpenAsar should be installed! You can check by looking for an "OpenAsar" option in your Discord settings.
echo Not installed? Try restarting Discord, running the script again, or if still not join our Discord server.
echo.
echo openasar.dev
echo.
pause
