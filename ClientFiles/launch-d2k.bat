@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
if exist spawn.ini (
    copy /Y spawn.ini d2k\spawn.ini
    REM Extract scenario name from spawn.ini
    for /f "tokens=2 delims==" %%a in ('findstr /B /C:"Scenario=" spawn.ini') do (
        set SCENARIO=%%a
        REM Remove any leading/trailing spaces
        set SCENARIO=!SCENARIO: =!
        
        REM Check if IsSinglePlayer=Yes to determine file handling
        findstr /C:"IsSinglePlayer=Yes" spawn.ini >nul 2>&1
        if !errorlevel! == 0 (
            REM Singleplayer - game loads by scenario name from data\Missions only (_SCENARIO.mis + SCENARIO.MAP)
            if not exist "d2k\data\Missions\" mkdir "d2k\data\Missions"
            set "SP_SRC="
            if exist "d2k\data\Missions\_!SCENARIO!.mis" set "SP_SRC=d2k\data\Missions"
            if not defined SP_SRC if exist "data\Missions\_!SCENARIO!.mis" set "SP_SRC=data\Missions"
            if defined SP_SRC (
                if exist "!SP_SRC!\_!SCENARIO!.mis" copy /Y "!SP_SRC!\_!SCENARIO!.mis" "d2k\data\Missions\_!SCENARIO!.mis" >nul 2>&1
                if exist "!SP_SRC!\!SCENARIO!.MAP" copy /Y "!SP_SRC!\!SCENARIO!.MAP" "d2k\data\Missions\!SCENARIO!.MAP" >nul 2>&1
            )
        ) else (
            REM Multiplayer/Skirmish/Co-Op - spawn exe uses fixed names in data\maps (_spawn.mis + map), so copy there too
            if not exist "d2k\data\Missions\" mkdir "d2k\data\Missions"
            if not exist "d2k\data\maps\" mkdir "d2k\data\maps"
            set "MAPSRC="
            if exist "Maps\Co-op\!SCENARIO!.map" set "MAPSRC=Maps\Co-op"
            if not defined MAPSRC if exist "Maps\Standard\!SCENARIO!.map" set "MAPSRC=Maps\Standard"
            if defined MAPSRC (
                if exist "!MAPSRC!\_!SCENARIO!.mis" (
                    copy /Y "!MAPSRC!\_!SCENARIO!.mis" "d2k\data\Missions\_!SCENARIO!.mis" >nul 2>&1
                    copy /Y "!MAPSRC!\_!SCENARIO!.mis" "d2k\data\maps\_spawn.mis" >nul 2>&1
                )
                if exist "!MAPSRC!\!SCENARIO!.map" (
                    copy /Y "!MAPSRC!\!SCENARIO!.map" "d2k\data\Missions\!SCENARIO!.map" >nul 2>&1
                    copy /Y "!MAPSRC!\!SCENARIO!.map" "d2k\data\maps\!SCENARIO!.map" >nul 2>&1
                )
                REM Game loads [Text], triggers, rules, music from map INI at .\MapsResourcePath\MissionMap.ini (MissionMap = spawn.ini Scenario=).
                REM Single copy to d2k\data\maps\ (likely MapsResourcePath) for debugging.
                if exist "!MAPSRC!\!SCENARIO!.ini" (
                    if not exist "d2k\data\maps\" mkdir "d2k\data\maps"
                    copy /Y "!MAPSRC!\!SCENARIO!.ini" "d2k\data\maps\!SCENARIO!.ini" >nul 2>&1
                )
            )
        )
    )
)
cd /d "%~dp0d2k"

REM Skip first argument (batch file name) and pass rest to game executable
shift

REM Which exe: dune2000.exe for singleplayer only; dune2000-spawn.exe for skirmish/multiplayer/co-op
REM (dune2000.exe does not handle multiplayer spawn.ini and crashes with "side out of range (255)")
REM (spawn.ini is now in d2k directory after copy)
findstr /C:"IsSinglePlayer=Yes" spawn.ini >nul 2>&1
if %errorlevel% == 0 (
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