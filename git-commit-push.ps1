param(
    [Parameter(Mandatory=$true)]
    [string]$Message
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

Write-Host "Commit et push de '$currentBranch'..." -ForegroundColor Cyan

git add -A
if ($LASTEXITCODE -ne 0) { exit 1 }

git commit -m $Message
if ($LASTEXITCODE -ne 0) { exit 1 }

git push -u origin $currentBranch
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Commit et push termines." -ForegroundColor Green