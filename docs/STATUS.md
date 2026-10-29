# Status

Honest capability list. Updated 29 Oct 2026 after the monorepo scaffold.

## Verified

- Git 2.54.0, Flutter 3.47.7, Dart 3.13.5, Temurin JDK 17.0.20.1, Node.js 24.15.0, npm 11.12.1, NestJS CLI 12.0.11, and PostgreSQL 18.6 respond to their version commands.
- `flutter doctor` reports the Android toolchain ready: SDK 36.0.0, platform android-36, build-tools 36.0.0, adb 37.0.1, licenses accepted.
- Chrome is available for UI runs (`flutter devices` lists Chrome and Edge).
- PostGIS 3.6.2 files and pgvector 0.8.7 files are on disk under PostgreSQL 18.
- `scripts/check-env.ps1` exits 0.
- `mobile`: `flutter analyze` reports no issues. `flutter test` passes (explore, guide reply, map, Arabic right-to-left, loading button). A release web build opened in Chrome: Explore shows the sky gradient, chips, and unloaded story cards; Map shows the labeled floor-plan preview; Ask Negarit shows the unconnected guide and message field.
- `api`: `npm run lint`, `npm test`, `npm run test:e2e`, and `npm run build` pass. `GET /health` returns status ok and labels Telebirr as demo and AI as mock. `GET /venues` returns the Adwa placeholder and `verified: false` until `DATABASE_URL` is set. `POST /payments/chapa/session` returns 503 until the Chapa secret is set. `POST /payments/telebirr/session` returns a labeled demo. OpenAPI is mounted at `/docs`.
- `admin`: `npm run lint` and `npm run build` pass. In Chrome, Overview, Venues, Content, Beacons, Offers, and Analytics each returned HTTP 200 on `http://localhost:3001`. The pages state that sign-in and venue data are not connected.
- Production npm dependencies report no known vulnerabilities (`npm audit --omit=dev`). Dev dependencies still report findings; they were not force-upgraded.

## Simulated

- Telebirr checkout. `POST /payments/telebirr/session` returns a labeled demo and does not call Telebirr.
- AI answers. `AI_PROVIDER=mock`. The visitor guide still says it is not connected.
- OTP. `OTP_DELIVERY=log`. No SMS provider is configured.
- Visitor map. The screen is still the floor-plan preview. A Google Maps key can be stored in `.env`, and the Android map SDK is not wired yet.

## Not started

- Applying `scripts/apply-db.ps1`. It reads `DATABASE_URL` from `.env`. That value is still blank, so the Adwa schema has not been applied to Neon. `CREATE EXTENSION` is still unverified.
- Auth, localization beyond the three scaffold languages, beacon engine, guided content, wayfinding queries, offers, and offline packs.
- Real BLE, NFC, Telebirr, and speech.
- Android phone install. A Samsung SM A105F was detected, and the debug build result was not confirmed.
- The GitHub remote is https://github.com/mr-Ayalk/Negarit_AI_Mobile_App. Actions passed on 29 Oct 2026 on https://github.com/mr-Ayalk/negarit-ai. The run on the current remote has not been confirmed yet.

## Known warnings

- `flutter doctor` reports an unknown Flutter upstream repository. The SDK runs.
- `flutter doctor` reports Visual Studio missing. That blocks Windows desktop builds only.
- `sdkmanager` is deprecated in favor of the Android CLI. Flutter accepts the installed SDK.
- pgvector on Windows is a community binary. `CREATE EXTENSION` has not succeeded yet.
