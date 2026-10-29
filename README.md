# Negarit AI

Multilingual, BLE-beacon-triggered visitor companion and local-commerce platform for museums and venues. The first venue is Adwa Museum.

The repository is a monorepo. The visitor shell, API health check, and admin app are scaffolds. Guided tours, beacons, and payments are not implemented yet.

## Stack

Flutter and Dart, NestJS and TypeScript, Next.js admin, PostgreSQL 18 with PostGIS and pgvector.

## Layout

| Path | What it is |
|---|---|
| `mobile/` | Flutter app. Android first, web and iOS projects included. |
| `api/` | NestJS API. Health at `/health`, OpenAPI at `/docs`. |
| `admin/` | Next.js admin and merchant dashboard. |
| `infra/` | Local Postgres notes. Docker is not used. |
| `docs/` | Specification, setup, decisions, and status. |

## Run locally

Install the toolchain with [docs/SETUP_WINDOWS.md](docs/SETUP_WINDOWS.md), then:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\check-env.ps1"
```

API:

```powershell
cd api
npm run start:dev
```

Admin (http://localhost:3001):

```powershell
cd admin
npm run dev
```

Mobile, in Chrome until a phone is attached:

```powershell
cd mobile
flutter run -d chrome
```

## Tests

```powershell
cd api; npm run lint; npm test; npm run test:e2e; npm run build
cd ..\admin; npm run lint; npm run build
cd ..\mobile; flutter analyze; flutter test
```

## Status

What has actually been run is listed in [docs/STATUS.md](docs/STATUS.md). Decisions are in [docs/DECISIONS.md](docs/DECISIONS.md).

## License

Proprietary. All rights reserved. See [LICENSE](LICENSE).
