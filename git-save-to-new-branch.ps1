param(
    [Parameter(Mandatory=$true)]
    [string]$BranchName,

    [Parameter(Mandatory=$false)]
    [string]$Message = "WIP"
)

git rev-parse --is-inside-work-tree *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Pas dans un depôt Git."
    exit 1
}

Write-Host "Creation de la branche '$BranchName'..." -ForegroundColor Cyan

git checkout -b $BranchName
if ($LASTEXITCODE -ne 0) { exit 1 }

git add -A
if ($LASTEXITCODE -ne 0) { exit 1 }

git commit -m $Message
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Branche '$BranchName' creee et commit effectue." -ForegroundColor Green