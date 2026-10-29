# Infrastructure

Local development uses the PostgreSQL 18 Windows service. Docker Desktop is not part of this setup. See `docs/DECISIONS.md` and `docs/SETUP_WINDOWS.md`.

Enable PostGIS and pgvector, once, with the superuser password supplied outside git:

```powershell
$env:PGPASSWORD = "<postgres-superuser-password>"
psql -U postgres -h 127.0.0.1 -d postgres -f "infra/postgres/enable-extensions.sql"
Remove-Item Env:PGPASSWORD
```

`CREATE EXTENSION` has not been verified on the development machine yet.
