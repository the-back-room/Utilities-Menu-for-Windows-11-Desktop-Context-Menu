@echo off
setlocal enabledelayedexpansion

:: Define the expected executable name and path
set "UWPSPY_FOLDER=C:\Utilities\UWPSpy"
set "UWPSPY_EXE=UWPSpy.exe"

:: IMMEDIATELY force the active directory to the absolute path
cd /d "%UWPSPY_FOLDER%"

:: Check if the executable exists in the absolute directory path
if not exist "%UWPSPY_EXE%" (
    echo [ERROR] %UWPSPY_EXE% was not found at %UWPSPY_FOLDER%.
    pause
    exit /b
)

:: Read the first command line argument
set "ARG1=%~1"
set "ARG2=%~2"

:: Evaluate command line arguments
if "%ARG1%"=="" goto LAUNCH_DEFAULT
if /i "%ARG1%"=="/light" goto LAUNCH_LIGHT
if /i "%ARG1%"=="/dark" goto LAUNCH_DARK
if /i "%ARG1%"=="/target" goto CHECK_TARGET

:: Fallback for invalid arguments
echo [WARNING] Unknown argument: %ARG1%
echo.
goto SHOW_HELP

:LAUNCH_DEFAULT
echo Launching UWPSpy using default system theme settings...
set "UWPSPY_DISABLE_DARK_MODE="
goto RUN

:LAUNCH_LIGHT
echo Forcing UWPSpy into Light Mode...
set "UWPSPY_DISABLE_DARK_MODE=1"
goto RUN

:LAUNCH_DARK
echo Forcing UWPSpy into Dark Mode (Clearing overrides)...
set "UWPSPY_DISABLE_DARK_MODE="
goto RUN

:CHECK_TARGET
:: If the user didn't type a process next to /target, prompt them to type it manually
if "%ARG2%"=="" (
    echo ---------------------------------------------------
    set /p "ARG2=Enter the target WinUI 3 process name (e.g. explorer.exe): "
    echo ---------------------------------------------------
)

:: Double check they didn't just hit enter leaving it totally blank
if "!ARG2!"=="" (
    echo [ERROR] No process name was specified.
    echo.
    goto SHOW_HELP
)

:: Verify the companion automation file is present in the workspace
if not exist "SpyTarget.ps1" (
    echo [ERROR] SpyTarget.ps1 was not found in this folder.
    pause
    exit /b
)

:: Pass the target parameter to the PowerShell automation engine
echo [INFO] Handing off control to the Automation Script...
powershell -NoProfile -ExecutionPolicy Bypass -File "SpyTarget.ps1" -TargetProcess "!ARG2!"
goto END

:SHOW_HELP
echo =======================================================
echo               UWPSpy Batch Wrapper Help
echo =======================================================
echo Usage: RunUWPSpy.bat [argument]
echo.
echo Available Arguments:
echo   /light             Forces Light Mode by setting UWPSPY_DISABLE_DARK_MODE=1.
echo   /dark              Clears overrides to rely on standard system dark theme.
echo   /target            Prompts you to enter a process to auto-inject.
echo   /target [name.exe] Automatically loads the given process into UI.
echo =======================================================
pause
exit /b

:RUN
start "" "%UWPSPY_EXE%"
:END
endlocal
