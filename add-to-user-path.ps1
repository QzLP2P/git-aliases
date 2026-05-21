$folder = $PSScriptRoot

if (-not (Test-Path $folder)) {
  Write-Error "Le dossier n'existe pas : $folder"
  exit 1
}

# Normalisation simple du chemin cible
$targetFolder = [System.IO.Path]::GetFullPath($folder).TrimEnd('\')

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

$paths = @()
if (-not [string]::IsNullOrWhiteSpace($userPath)) {
  $paths = $userPath -split ';' |
  Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
  ForEach-Object { [System.IO.Path]::GetFullPath($_).TrimEnd('\') }
}

if ($paths -contains $targetFolder) {
  Write-Host "Le dossier est deja present dans le PATH utilisateur." -ForegroundColor Yellow
}
else {
  $newPath = (($paths + $targetFolder) | Select-Object -Unique) -join ';'
  [Environment]::SetEnvironmentVariable("Path", $newPath, "User")

  Write-Host "Dossier ajoute au PATH utilisateur :" -ForegroundColor Green
  Write-Host "  $targetFolder"
}

# Recharge le PATH dans la session courante
$env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")

Write-Host ""
Write-Host "PATH courant recharge pour cette session." -ForegroundColor Cyan
Write-Host ""

Write-Host "Verification du PATH utilisateur :" -ForegroundColor Cyan
([Environment]::GetEnvironmentVariable("Path", "User") -split ';') | ForEach-Object {
  Write-Host " - $_"
}

Write-Host ""
Write-Host "Verification des commandes :" -ForegroundColor Cyan

$commandsToCheck = @("gsb", "gsnb", "gro", "gtp", "gcp", "gsh", "gbcp")

foreach ($cmd in $commandsToCheck) {
  $found = where.exe $cmd 2>$null
  if ($LASTEXITCODE -eq 0 -and $found) {
    Write-Host "OK  $cmd -> $found" -ForegroundColor Green
  }
  else {
    Write-Host "KO  $cmd non trouve" -ForegroundColor Red
  }
}