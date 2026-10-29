# Status

Honest capability list. Updated 29 Oct 2026 after the Windows toolchain setup.

## Verified

- Git 2.54.0, Flutter 3.47.7, Dart 3.13.5, Temurin JDK 17.0.20.1, Node.js 24.15.0, npm 11.12.1, NestJS CLI 12.0.11, and PostgreSQL 18.6 respond to their version commands.
- `flutter doctor` reports the Android toolchain ready: SDK 36.0.0, platform android-36, build-tools 36.0.0, adb 37.0.1, licenses accepted.
- Chrome is available for UI runs (`flutter devices` lists Chrome and Edge).
- PostGIS 3.6.2 files are installed under PostgreSQL 18 (`postgis.control` is present).
- pgvector 0.8.7 files are copied under PostgreSQL 18 (`vector.control` and `vector.dll`).
- `scripts/check-env.ps1` exits 0.

## Simulated

Nothing in the product is simulated yet. The app, API, and admin app are not created.

## Not started

- `CREATE EXTENSION postgis` and `CREATE EXTENSION vector` (blocked on the PostgreSQL superuser password).
- Monorepo applications (`mobile`, `api`, `admin`).
- Auth, localization, beacon engine, guided mode, wayfinding, AI, offers, payments, offline packs, admin UI.
- Real BLE, NFC, Chapa, Telebirr, and speech. These will be feature-flagged until tested.
- Android phone. `adb devices` has no handset attached.
- GitHub remote. `gh` is not installed, and the repository has not been pushed.

## Known warnings

- `flutter doctor` reports an unknown Flutter upstream repository. The SDK runs. It was not reinstalled.
- `flutter doctor` reports Visual Studio missing. That blocks Windows desktop builds only.
- `sdkmanager` is deprecated in favor of the Android CLI. Flutter accepts the installed SDK.
