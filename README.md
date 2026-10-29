# Negarit AI

Multilingual, BLE-beacon-triggered visitor companion and local-commerce platform for museums and venues. The first venue is Adwa Museum.

The visitor app, API, and admin dashboard are not in this tree yet. The Windows toolchain for building them is installed and checked.

## Stack

Flutter and Dart, NestJS and TypeScript, PostgreSQL 18 with PostGIS and pgvector.

## Current state

| Area | State |
|---|---|
| Requirements | Extracted to [docs/SRS.md](docs/SRS.md) |
| Windows toolchain | Documented in [docs/SETUP_WINDOWS.md](docs/SETUP_WINDOWS.md) |
| Decisions | [docs/DECISIONS.md](docs/DECISIONS.md) |
| What is actually verified | [docs/STATUS.md](docs/STATUS.md) |

Check the machine:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\check-env.ps1"
```

## License

Proprietary. All rights reserved. See [LICENSE](LICENSE).
