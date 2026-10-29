# Apply the core schema and the Adwa placeholder seed.
# Uses DATABASE_URL from the gitignored .env when it is set.
# Otherwise uses PGPASSWORD for the local postgres superuser.
# This script does not store or print those secrets.

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$envFile = Join-Path $root ".env"

function Read-DotEnvValue([string]$Name) {
  if (-not (Test-Path $envFile)) { return $null }
  foreach ($line in Get-Content $envFile) {
    if ($line -match "^\s*$([regex]::Escape($Name))=(.*)$") {
      $value = $Matches[1].Trim().Trim('"').Trim("'")
      if ($value -and $value -notmatch 'change-me') { return $value }
    }
  }
  return $null
}

if (Read-DotEnvValue "DATABASE_URL") {
  Push-Location (Join-Path $root "api")
  try {
    node ./scripts/apply-db.mjs
    exit $LASTEXITCODE
  } finally {
    Pop-Location
  }
}

if (-not $env:PGPASSWORD) {
  Write-Error "Set DATABASE_URL in .env, or set PGPASSWORD for the local postgres superuser. Do not commit either value."
  exit 1
}

$psql = "C:\Program Files\PostgreSQL\18\bin\psql.exe"

function Invoke-Psql {
  param([string]$Database, [string]$File, [string]$Command)
  if ($File) {
    & $psql -U postgres -h 127.0.0.1 -d $Database -v ON_ERROR_STOP=1 -f $File
  } else {
    & $psql -U postgres -h 127.0.0.1 -d $Database -v ON_ERROR_STOP=1 -c $Command
  }
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

$existing = & $psql -U postgres -h 127.0.0.1 -d postgres -tAc "SELECT datname FROM pg_database WHERE datname = 'negarit'"
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
if ($existing.Trim() -ne "negarit") {
  Invoke-Psql -Database "postgres" -Command "CREATE DATABASE negarit"
}

Write-Host "Enabling PostGIS and pgvector in negarit"
& $psql -U postgres -h 127.0.0.1 -d negarit -v ON_ERROR_STOP=1 -f (Join-Path $root "infra\postgres\enable-extensions.sql")
if ($LASTEXITCODE -ne 0) {
  Write-Error "CREATE EXTENSION failed. Schema files were not applied."
  exit $LASTEXITCODE
}

Invoke-Psql -Database "negarit" -File (Join-Path $root "infra\postgres\migrations\001_core.sql")
Invoke-Psql -Database "negarit" -File (Join-Path $root "infra\postgres\seed\001_adwa.sql")
Write-Host "Adwa placeholder seed applied"
