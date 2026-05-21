param(
    [Parameter(Mandatory=$true)]
    [string]$TagName,

    [Parameter(Mandatory=$false)]
    [string]$Message
)

git rev-parse --is-inside-work-tree *> $null
if ($LASTEXITCODE -ne 0) {
    Write-Error "Pas dans un depôt Git."
    exit 1
}

if ([string]::IsNullOrWhiteSpace($Message)) {
    $Message = $TagName
}

Write-Host "Creation du tag '$TagName'..." -ForegroundColor Cyan

git tag -a $TagName -m $Message
if ($LASTEXITCODE -ne 0) { exit 1 }

git push origin $TagName
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Tag '$TagName' cree et pousse." -ForegroundColor Green