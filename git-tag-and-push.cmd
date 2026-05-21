@echo off
SetLocal
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "%~dp0git-tag-and-push.ps1" %*
exit /b %ERRORLEVEL%
