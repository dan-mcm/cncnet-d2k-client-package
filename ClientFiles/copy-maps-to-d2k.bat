@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo Copying maps to d2k directories...

REM Ensure target directories exist
if not exist "d2k\data\Missions\" mkdir "d2k\data\Missions"
if not exist "d2k\data\maps\" mkdir "d2k\data\maps"

REM Copy Campaign maps (singleplayer) to d2k\data\Missions\
echo Copying Campaign maps...
for /d %%D in ("Maps\Campaign\*") do (
    echo   Processing %%~nxD...
    for %%F in ("%%D\_*.MIS") do (
        copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    )
    for %%F in ("%%D\*.MAP") do (
        copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    )
    for %%F in ("%%D\*.ini") do (
        copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    )
)

REM Copy Co-op maps to both d2k\data\Missions\ and d2k\data\maps\
echo Copying Co-op maps...
for %%F in ("Maps\Co-op\_*.MIS") do (
    copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    copy /Y "%%F" "d2k\data\maps\%%~nxF" >nul 2>&1
)
for %%F in ("Maps\Co-op\*.map") do (
    copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    copy /Y "%%F" "d2k\data\maps\%%~nxF" >nul 2>&1
)
for %%F in ("Maps\Co-op\*.ini") do (
    copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    copy /Y "%%F" "d2k\data\maps\%%~nxF" >nul 2>&1
)

REM Copy Standard maps to both d2k\data\Missions\ and d2k\data\maps\
echo Copying Standard maps...
for %%F in ("Maps\Standard\_*.mis") do (
    copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    copy /Y "%%F" "d2k\data\maps\%%~nxF" >nul 2>&1
)
for %%F in ("Maps\Standard\*.map") do (
    copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    copy /Y "%%F" "d2k\data\maps\%%~nxF" >nul 2>&1
)
for %%F in ("Maps\Standard\*.ini") do (
    copy /Y "%%F" "d2k\data\Missions\%%~nxF" >nul 2>&1
    copy /Y "%%F" "d2k\data\maps\%%~nxF" >nul 2>&1
)

echo.
echo Done! All maps have been copied to d2k\data\Missions\ and d2k\data\maps\
pause

