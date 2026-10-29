# Apply the core schema and the Adwa placeholder seed.
# Set PGPASSWORD to the postgres superuser password in this terminal.
# This script does not store or invent that password.

$ErrorActionPreference = "Stop"
if (-not $env:PGPASSWORD) {
  Write-Error "Set PGPASSWORD to the postgres superuser password in this terminal. Do not commit it."
  exit 1
}

$psql = "C:\Program Files\PostgreSQL\18\bin\psql.exe"
$root = Split-Path -Parent $PSScriptRoot

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
