@echo off
SetLocal
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "%~dp0git-rebase-onto.ps1" %*
exit /b %ERRORLEVEL%
