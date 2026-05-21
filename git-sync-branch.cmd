@echo off
SetLocal
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "%~dp0git-sync-branch.ps1" %*
exit /b %ERRORLEVEL%
