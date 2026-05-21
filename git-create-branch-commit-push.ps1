param(
    [Parameter(Mandatory=$true)]
    [string]$BranchName,

    [Parameter(Mandatory=$true)]
    [string]$Message
)

git rev-parse --is-inside-work-tree *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Pas dans un depot Git."
    exit 1
}

Write-Host "Creation de la branche '$BranchName'..." -ForegroundColor Cyan

git checkout -b $BranchName
if ($LASTEXITCODE -ne 0) { exit 1 }

git add -A
if ($LASTEXITCODE -ne 0) { exit 1 }

git commit -m $Message
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Push de la branche '$BranchName' sur origin..." -ForegroundColor Cyan

git push -u origin $BranchName
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Branche '$BranchName' creee, committee et poussee." -ForegroundColor Green