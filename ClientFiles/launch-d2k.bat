@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0d2k"

REM Skip first argument (batch file name) and pass rest to game executable
shift

REM Which exe: dune2000.exe for singleplayer only; dune2000-spawn.exe for skirmish/multiplayer/co-op
REM (dune2000.exe does not handle multiplayer spawn.ini and crashes with "side out of range (255)")
REM Assumes all mission/map files are already in the correct directories (d2k\data\Missions\ and d2k\data\maps\)
if exist spawn.ini (
    findstr /C:"IsSinglePlayer=Yes" spawn.ini >nul 2>&1
    if !errorlevel! == 0 (
        REM Singleplayer mission - use dune2000.exe
        if exist dune2000.exe (
            start dune2000.exe %*
        ) else (
            echo dune2000.exe not found for singleplayer!
            pause
        )
    ) else (
        REM Multiplayer / Skirmish / Co-op - use dune2000-spawn.exe
        if exist dune2000-spawn.exe (
            start dune2000-spawn.exe %*
        ) else (
            echo dune2000-spawn.exe not found for multiplayer!
            pause
        )
    )
) else (
    REM No spawn.ini found, default to spawn exe for multiplayer
    if exist dune2000-spawn.exe (
        start dune2000-spawn.exe %*
    ) else (
        echo dune2000-spawn.exe not found!
        pause
    )
)