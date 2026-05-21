$scriptDir = (Get-Location).Path

$wrappers = @(
    @{ Ps1 = "git-sync-branch.ps1";        Long = "git-sync-branch.cmd";        Short = "gsb.cmd"  },
    @{ Ps1 = "git-save-to-new-branch.ps1"; Long = "git-save-to-new-branch.cmd"; Short = "gsnb.cmd" },
    @{ Ps1 = "git-rebase-onto.ps1";        Long = "git-rebase-onto.cmd";        Short = "gro.cmd"  },
    @{ Ps1 = "git-tag-and-push.ps1";       Long = "git-tag-and-push.cmd";       Short = "gtp.cmd"  },
    @{ Ps1 = "git-commit-push.ps1";        Long = "git-commit-push.cmd";        Short = "gcp.cmd"  },
    @{ Ps1 = "git-scripts-help.ps1";       Long = "git-scripts-help.cmd";       Short = "gsh.cmd"  },
    @{ Ps1 = "git-create-branch-commit-push.ps1"; Long = "git-create-branch-commit-push.cmd"; Short = "gbcp.cmd" }
)

Write-Host "Generation des wrappers CMD dans :" -ForegroundColor Cyan
Write-Host "  $scriptDir"
Write-Host ""

foreach ($wrapper in $wrappers) {
    $ps1Path = Join-Path $scriptDir $wrapper.Ps1

    if (-not (Test-Path $ps1Path)) {
        Write-Warning "Script introuvable : $($wrapper.Ps1)"
        continue
    }

    $ps1FileName = $wrapper.Ps1

    $cmdContent = @"
@echo off
SetLocal
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "%~dp0$ps1FileName" %*
exit /b %ERRORLEVEL%
"@

    $longCmdPath = Join-Path $scriptDir $wrapper.Long
    $shortCmdPath = Join-Path $scriptDir $wrapper.Short

    Set-Content -Path $longCmdPath -Value $cmdContent -Encoding ASCII
    Set-Content -Path $shortCmdPath -Value $cmdContent -Encoding ASCII

    Write-Host "Cree :" -ForegroundColor Green
    Write-Host "  - $($wrapper.Long)"
    Write-Host "  - $($wrapper.Short)"
}

Write-Host ""
Write-Host "Termine." -ForegroundColor Cyan