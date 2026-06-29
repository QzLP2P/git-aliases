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

# Mettre de cote les changements en attente (suivis et non suivis)
$stashed = $false
if (git status --porcelain) {
    Write-Host "Changements en attente detectes, mise de cote (stash)..." -ForegroundColor Yellow
    git stash push --include-untracked --message "gsb-auto-stash"
    if ($LASTEXITCODE -ne 0) { exit 1 }
    $stashed = $true
}

git fetch origin
if ($LASTEXITCODE -ne 0) { exit 1 }

git checkout $Branch
if ($LASTEXITCODE -ne 0) { exit 1 }

git pull --rebase origin $Branch
if ($LASTEXITCODE -ne 0) { exit 1 }

# Reappliquer les changements mis de cote
if ($stashed) {
    Write-Host "Reapplication des changements mis de cote (stash pop)..." -ForegroundColor Yellow
    git stash pop
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Conflit lors de la reapplication du stash. Resolvez-le manuellement (votre travail est conserve dans le stash)."
        exit 1
    }
}

Write-Host "Branche '$Branch' synchronisee." -ForegroundColor Green