# Status

Honest capability list. Updated 29 Oct 2026 after the monorepo scaffold.

## Verified

- Git 2.54.0, Flutter 3.47.7, Dart 3.13.5, Temurin JDK 17.0.20.1, Node.js 24.15.0, npm 11.12.1, NestJS CLI 12.0.11, and PostgreSQL 18.6 respond to their version commands.
- `flutter doctor` reports the Android toolchain ready: SDK 36.0.0, platform android-36, build-tools 36.0.0, adb 37.0.1, licenses accepted.
- Chrome is available for UI runs (`flutter devices` lists Chrome and Edge).
- PostGIS 3.6.2 files and pgvector 0.8.7 files are on disk under PostgreSQL 18.
- `scripts/check-env.ps1` exits 0.
- `mobile`: `flutter analyze` reports no issues. `flutter test` passes (8 tests), including a profile switch from English to Arabic, saving 5gna Ber into Favorites, choosing the Halls interest, and signing out a stored visitor. The visitor screens use the drum logo and the sunset palette. Explore lists the eight Adwa places and opens each one. Ask Negarit answers from that visit path. Profile keeps the sign-in address, language, interests, and saved places on the phone.
- `api`: `npm run lint`, `npm test`, `npm run test:e2e`, and `npm run build` pass. With `DATABASE_URL` set, the venue service returns `source: database` and slug `adwa-museum`. Chapa accepted the saved secret (`GET /v1/banks` returned 200). `POST /payments/telebirr/session` returns a labeled demo. OpenAPI is mounted at `/docs`.
- `scripts/apply-db.ps1` applied the Adwa schema on 29 Oct 2026. The hosted database has PostGIS 3.6.4, pgvector 0.8.6, one venue (`adwa-museum`), and eight zones.
- Android phone. A debug build was installed on the Samsung SM A105F and opened.
- `admin`: `npm run lint` and `npm run build` pass. In Chrome, Overview, Venues, Content, Beacons, Offers, and Analytics each returned HTTP 200 on `http://localhost:3001`. The pages state that sign-in and venue data are not connected.
- Production npm dependencies report no known vulnerabilities (`npm audit --omit=dev`). Dev dependencies still report findings; they were not force-upgraded.

## Simulated

- Telebirr checkout. `POST /payments/telebirr/session` returns a labeled demo and does not call Telebirr.
- AI answers. `AI_PROVIDER=mock`. Ask Negarit answers from the eight place names stored on the phone.
- OTP. `OTP_DELIVERY=log`. `POST /auth/otp/request` prints a six-digit code in the API log and does not return it. There is no SMS provider.
- Visitor map. The installed debug app opens the outdoor map for Adwa 00KM Museum in Piassa, with "Inside the visit" for the eight-place schematic. The maps key is packaged from gitignored `local.properties`. A phone screenshot does not capture the map surface, and the recent device log had no maps key error.

## Not started

- A cloud account, visit history, localization beyond the three scaffold languages, beacon engine, guided content, wayfinding queries, offers, and offline packs. Sign-in still stores only the address on this phone.
- Real BLE, NFC, Telebirr, and speech.
- The GitHub remote is https://github.com/mr-Ayalk/Negarit_AI_Mobile_App. Actions passed on 29 Oct 2026 on https://github.com/mr-Ayalk/negarit-ai. The run on the current remote has not been confirmed yet.

## Known warnings

- `flutter doctor` reports an unknown Flutter upstream repository. The SDK runs.
- `flutter doctor` reports Visual Studio missing. That blocks Windows desktop builds only.
- `sdkmanager` is deprecated in favor of the Android CLI. Flutter accepts the installed SDK.
- pgvector on the local Windows install is a community binary. The hosted database accepted `CREATE EXTENSION` for PostGIS and pgvector.
