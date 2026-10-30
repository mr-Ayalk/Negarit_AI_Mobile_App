# Status

Honest capability list. Updated 29 Oct 2026 after the monorepo scaffold.

## Verified

- Git 2.54.0, Flutter 3.47.7, Dart 3.13.5, Temurin JDK 17.0.20.1, Node.js 24.15.0, npm 11.12.1, NestJS CLI 12.0.11, and PostgreSQL 18.6 respond to their version commands.
- `flutter doctor` reports the Android toolchain ready: SDK 36.0.0, platform android-36, build-tools 36.0.0, adb 37.0.1, licenses accepted.
- Chrome is available for UI runs (`flutter devices` lists Chrome and Edge).
- PostGIS 3.6.2 files and pgvector 0.8.7 files are on disk under PostgreSQL 18.
- `scripts/check-env.ps1` exits 0.
- `mobile`: `flutter analyze` reports no issues. `flutter test` passes (18 tests). The app opens on Choose language, then permissions, sign-in, the place list, and home. Widget tests walk that path through the entrance welcome, the exhibit, the offer, and checkout, and open the map, the guide sample, the itinerary, profile, and the break sheet. Unit tests still cover the beacon rules, place codes, the visit-list guide parser, stored zone text, and the visit-order helper. The 14 screens use the redesign wording. Distances, prices, the warrior-cape offer, the offline Ready line, and the guide citation are that layout. They are not a surveyed route, a reviewed museum source, a downloaded pack, or a payment. Pay, reserve, and the audio controls say they are not connected. Bluetooth is not scanned. The Samsung still has the older debug build until this app is installed again.
- `api`: `npm test` passes (12 tests) and `npm run build` passes. The guide unit tests classify coffee, keep a hall question off one place, and refuse a question outside the visit list. After the rebuild, a live `POST /guide/ask` did the same: coffee came back as a place, and a question outside the list came back unknown. On 29 Oct 2026, `GET /venues/adwa-museum` returned `source: database`. The entrance text is the stored placeholder sentence in English and Amharic, with provenance `placeholder`. Coffee has no story. Chapa accepted the saved secret (`GET /v1/banks` returned 200). `POST /payments/telebirr/session` returns a labeled demo. OpenAPI is mounted at `/docs`. Lint and the guide e2e were not re-run.
- `scripts/apply-db.ps1` applied the Adwa schema on 29 Oct 2026. The hosted database has PostGIS 3.6.4, pgvector 0.8.6, one venue (`adwa-museum`), and eight zones.
- Android phone. A debug build was installed on the Samsung SM A105F and opened.
- `admin`: `npm run lint` and `npm run build` pass. Venues is a partial prerender. On 30 Oct 2026, `http://127.0.0.1:3001/venues` returned Adwa Museum from the API with source database, the eight zones, the entrance placeholder sentence in English and Amharic, and no stored story on the other zones. The page says no operator is signed in. Overview and Content still say their data is not loaded. A desktop click-through was not completed; the pages were checked by HTTP.
- Production npm dependencies report no known vulnerabilities (`npm audit --omit=dev`). Dev dependencies still report findings; they were not force-upgraded.

## Simulated

- Telebirr checkout. `POST /payments/telebirr/session` returns a labeled demo and does not call Telebirr.
- AI answers. `AI_PROVIDER=mock`. `POST /guide/ask` classifies the eight places and does not call a model. A question outside that list is refused. The guide screen in the app shows the redesign’s sample exchange and does not call that service.
- OTP. `OTP_DELIVERY=log`. `POST /auth/otp/request` prints a six-digit code in the API log and does not return it. There is no SMS provider.
- Visitor map. The map screen is the redesign sheet: filters, a drawn line, Nearest coffee, and Parking. The distances on that sheet are the layout, not a surveyed route. The phone has not been reinstalled with this screen.
- Place arrival. The entrance screen shows the redesign greeting. The phone does not scan Bluetooth. The camera does not scan, and NFC is not read.

## Not started

- A cloud account, visit history, and localization beyond the language list on the first screen. English, Amharic, and Arabic can be stored on the phone. The other language rows are labels. The offer and checkout screens do not charge, and no offline pack is downloaded. Sign-in still prints a code in the API log and does not create a server account.
- Real BLE, camera QR scanning, NFC, Telebirr, and speech.
- The GitHub remote is https://github.com/mr-Ayalk/Negarit_AI_Mobile_App. Actions passed on 29 Oct 2026 on https://github.com/mr-Ayalk/negarit-ai. The run on the current remote has not been confirmed yet.

## Known warnings

- `flutter doctor` reports an unknown Flutter upstream repository. The SDK runs.
- `flutter doctor` reports Visual Studio missing. That blocks Windows desktop builds only.
- `sdkmanager` is deprecated in favor of the Android CLI. Flutter accepts the installed SDK.
- pgvector on the local Windows install is a community binary. The hosted database accepted `CREATE EXTENSION` for PostGIS and pgvector.
