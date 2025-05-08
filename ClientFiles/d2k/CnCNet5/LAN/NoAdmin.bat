@echo off

REG ADD "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /f /v "%~dp0CnCNet.LAN.IrcD.Server.exe" /t REG_SZ /d RUNASINVOKER
