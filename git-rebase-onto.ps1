param(
    [Parameter(Mandatory=$true)]
    [string]$TargetBranch,

    [Parameter(Mandatory=$false)]
    [ValidateSet("normal", "interactive")]
    [string]$Mode = "normal"
)

git rev-parse --is-inside-work-tree *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Pas dans un depôt Git."
    exit 1
}

$currentBranch = git branch --show-current
if (-not $currentBranch) {
    Write-Error "Impossible de determiner la branche courante."
    exit 1
}

if ($currentBranch -eq $TargetBranch) {
    Write-Error "Tu es dejà sur la branche cible '$TargetBranch'."
    exit 1
}

Write-Host "Mise à jour de '$TargetBranch'..." -ForegroundColor Cyan

git fetch origin
if ($LASTEXITCODE -ne 0) { exit 1 }

git checkout $TargetBranch
if ($LASTEXITCODE -ne 0) { exit 1 }

git pull --rebase origin $TargetBranch
if ($LASTEXITCODE -ne 0) { exit 1 }

git checkout $currentBranch
if ($LASTEXITCODE -ne 0) { exit 1 }

if ($Mode -eq "interactive") {
    Write-Host "Rebase interactif de '$currentBranch' sur '$TargetBranch'..." -ForegroundColor Cyan
    git rebase -i $TargetBranch
} else {
    Write-Host "Rebase de '$currentBranch' sur '$TargetBranch'..." -ForegroundColor Cyan
    git rebase $TargetBranch
}

if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Rebase termine." -ForegroundColor Green