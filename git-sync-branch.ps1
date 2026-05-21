param(
    [Parameter(Mandatory=$true)]
    [string]$Branch
)

git rev-parse --is-inside-work-tree *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Pas dans un depôt Git."
    exit 1
}

Write-Host "Synchronisation de la branche '$Branch'..." -ForegroundColor Cyan

git fetch origin
if ($LASTEXITCODE -ne 0) { exit 1 }

git checkout $Branch
if ($LASTEXITCODE -ne 0) { exit 1 }

git pull --rebase origin $Branch
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Branche '$Branch' synchronisee." -ForegroundColor Green