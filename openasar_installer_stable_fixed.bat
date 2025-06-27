@echo off
echo uninstall openasar if you already have it installed by going to %Localappdata%/Discord/app-*/ 
echo delete the 39kb app.asar and rename the app.asar.backup or whatever thats about 9000kb to just app.asar
echo if you do not have it, then it is fine just the "perma" backup that's created won't be the original file
echo it will be made on future updates if/when you run this again
echo this is in case you for some reason want to revert but accidentally ran this multiple times

pause
echo Closing Discord... (wait around 5 seconds)

REM Terminate Discord multiple times to ensure it's closed
C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul
C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul
C:\Windows\System32\TASKKILL.exe /f /im Discord.exe > nul 2> nul

C:\Windows\System32\TIMEOUT.exe /t 5 /nobreak > nul 2> nul

echo Installing OpenAsar... (ignore any blue output flashes)

set "discordBaseDir=%localappdata%\Discord"

for /d %%i in ("%discordBaseDir%\app-*") do (
    if exist "%%i\resources\app.asar" (
        echo Processing: %%i

        if exist "%%i\resources\app.asar" (
            REM Create permanent backup if it doesn't already exist
            if not exist "%%i\resources\perma.app.asar.backup" (
                copy /y "%%i\resources\app.asar" "%%i\resources\perma.app.asar.backup" > nul 2> nul
		echo saved perma.app.asar.backup - this will not be overwritten, in case you want to revert
            )
            copy /y "%%i\resources\app.asar" "%%i\resources\app.asar.backup" > nul 2> nul
        )

        if exist "%%i\resources\_app.asar" (
            if not exist "%%i\resources\perma._app.asar.backup" (
                copy /y "%%i\resources\_app.asar" "%%i\resources\perma._app.asar.backup" > nul 2> nul
		echo saved perma._app.asar.backup - this will not be overwritten, in case you want to revert
            )
            copy /y "%%i\resources\_app.asar" "%%i\resources\_app.asar.backup" > nul 2> nul
        )

        if exist "%%i\resources\app.asar.orig" (
            if not exist "%%i\resources\perma.app.asar.orig.backup" (
                copy /y "%%i\resources\app.asar.orig" "%%i\resources\perma.app.asar.orig.backup" > nul 2> nul
		echo saved perma.app.asar.orig.backup - this will not be overwritten, in case you want to revert
            )
            copy /y "%%i\resources\app.asar.orig" "%%i\resources\app.asar.orig.backup" > nul 2> nul
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
