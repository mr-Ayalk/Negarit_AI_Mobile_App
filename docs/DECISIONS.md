# Decisions

Short architecture decision records. The newest entry is at the top.

## ADR-019 — Place arrival is simulated until real beacons exist

**Status:** Accepted (29 Oct 2026)

The phone does not scan Bluetooth. Explore and the map let the visitor choose the place they are standing in, and that control is labeled simulated. The zone rules still smooth a signal, wait 3 seconds before entering, leave only below a lower threshold, prefer the stronger stable signal, and suppress a repeat announcement for 5 minutes. Those rules are covered by unit tests with fed samples. The entrance welcome is shown once in a session. QR, NFC, and installed beacons are not in the app. A reviewed story is still not loaded.

## ADR-018 — The visitor profile stays on the phone

**Status:** Accepted (29 Oct 2026)

Sign-in still uses a code printed in the API log. After the code is accepted, the phone stores the address, the chosen interests, and the saved places on the device. Sign out clears the address and leaves the language, interests, and saved places. There is no cloud profile and no visit history. A place screen names the stop and says a reviewed story is not loaded. Amharic and Arabic strings for these controls are still drafts.

## ADR-017 — Sign-in codes are printed in the API log

**Status:** Accepted (29 Oct 2026)

There is no SMS provider. `POST /auth/otp/request` creates a six-digit code, prints it in the API log, and does not return the code. The phone profile can switch among English, Amharic, and Arabic, and that choice stays on the device. Amharic and Arabic strings are still drafts.

## ADR-016 — The outdoor pin is the published Adwa 00KM location

**Status:** Accepted (29 Oct 2026)

The phone map uses Google Maps when `MAPS_API_KEY` is present in the gitignored Android `local.properties` file. The pin is the Wikipedia coordinate for the Adwa 00KM Museum, 9.0332° N, 38.7533° E, in Piassa. The indoor screen stays a schematic of the eight visit places because the building has not been surveyed into map coordinates. The key is not committed.

## ADR-015 — The visitor app follows the drum logo

**Status:** Accepted (29 Oct 2026)

The phone icon and the in-app mark use the drum artwork. The interface uses the sunset, ember, and earth colors from that image. The eight Adwa places are the visit on the phone: entrance, 5gna Ber, 6gna Ber, coffee, restaurant, parking, restrooms, and exits. Asking about those places answers from that visit path. Recorded exhibit audio and reviewed museum stories are not in the app.

## ADR-014 — Neon, Chapa, and Google Maps are the live credentials

**Status:** Accepted (29 Oct 2026)

The hosted database is a Neon `DATABASE_URL` until the API moves to a VPS. Chapa checkout is called only when `CHAPA_SECRET_KEY` is set. The Google Maps key is stored for the visitor map, and the screen stays the floor-plan preview until the map SDK is added. Telebirr, SMS OTP, and the AI providers stay labeled demos. None of those secrets are committed. `scripts/apply-db.ps1` uses the Neon URL from `.env` when it is present, and the local superuser password only as a fallback.

## ADR-013 — The first schema is SQL, applied by hand

**Status:** Accepted (29 Oct 2026)

The core tables and the Adwa placeholder seed live in `infra/postgres`. `scripts/apply-db.ps1` applies them when `PGPASSWORD` is set to the PostgreSQL superuser password. That password is not in the repo, so the script has not been run successfully. Until it has, `GET /venues` returns the same placeholder from the API process and marks it unverified. PostGIS geography and pgvector embeddings are not columns yet, because `CREATE EXTENSION` is still unverified.

## ADR-012 — Visitor screens follow the sky-gradient reference

**Status:** Accepted (29 Oct 2026)

The visitor app uses the reference layout for type, color, rounded cards, chips, and the bottom bar. Plus Jakarta Sans and the existing brand colors stay. Place names and photos from those reference images are not used. Adwa Museum is named as the first venue, and stories, audio, zones, and guide answers stay unloaded until real content and a connected guide exist. Amharic and Arabic strings added for this screen are still drafts.

## ADR-011 — Drift waits for the offline venue schema

**Status:** Accepted (29 Oct 2026)

The visitor app will store venue packs in Drift. The scaffold does not generate an empty database. The first Drift tables arrive with the offline pack, when there is a schema to migrate.

## ADR-010 — Scaffold translations for Amharic and Arabic are drafts

**Status:** Accepted (29 Oct 2026)

English UI strings in the app shell are the source. Amharic and Arabic strings are included so right-to-left layout and Ethiopic text can be tested. They have not had a native-speaker review. Tier 1 content still requires that review before it is treated as human-verified.

## ADR-009 — The API keeps Nest 12 oxlint and Vitest

**Status:** Accepted (29 Oct 2026)

`nest new` for Nest 12 generates oxlint and Vitest, not ESLint and Jest. Adding a second pair would duplicate the gates. The admin app still uses ESLint because that is what `create-next-app` generates.

## ADR-008 — Mobile linting stays on flutter_lints

**Status:** Accepted (29 Oct 2026)

Flutter 3.47 scaffolds `flutter_lints` 6. That set is the analyzer gate for the app. `very_good_analysis` was not added on top.

## ADR-007 — pgvector on Windows is a community binary until `CREATE EXTENSION` succeeds

**Status:** Accepted (29 Oct 2026)

PostgreSQL 18 is already installed. pgvector publishes no official Windows installer. Visual Studio C++ build tools and Docker Desktop were both rejected for this PC (no Visual Studio install, and RAM is under 8 GB). The files copied into `C:\Program Files\PostgreSQL\18` are pgvector 0.8.7 from `andreiramani/pgvector_pgsql_windows`, SHA-256 `7c4ae0e2b2cb1e547779209a34a7d3f05b82fd7912818bf3d7042266eda87e7d`.

The extension is not enabled in a database yet. Retrieval may use full-text search, labeled as such, until `CREATE EXTENSION vector` succeeds.

## ADR-006 — Development OTP is written to the API log

**Status:** Accepted (29 Oct 2026)

No SMS or email provider was provided. Local sign-in will print the one-time code in the API log. Production delivery stays behind configuration and will not ship that behavior.

## ADR-005 — Venue map uses a floor-plan overlay until a map key exists

**Status:** Accepted (29 Oct 2026)

No Google Maps or Mapbox key was provided. Indoor guidance is a floor-plan image with POI pins. Outdoor tiles can be added later without changing the POI model.

## ADR-004 — AI calls use a mock provider until keys exist

**Status:** Accepted (29 Oct 2026)

No LLM, embedding, speech, or translation key was provided. The API will expose a provider interface and a mock implementation that is labeled in the UI and in `docs/STATUS.md`. Keys stay on the server.

## ADR-003 — The repository license is proprietary

**Status:** Accepted (29 Oct 2026)

Negarit AI is a commercial product. The default license is All rights reserved. MIT and Apache-2.0 were not chosen. A written decision is required before any open-source license replaces `LICENSE`.

## ADR-002 — Local database is native PostgreSQL, not Docker

**Status:** Accepted (29 Oct 2026)

The development PC has 7.88 GB RAM and about 1 GB free during the audit. Docker Desktop is not installed. PostgreSQL 18 already runs as a Windows service.

## ADR-001 — Keep PostgreSQL 18 instead of installing PostgreSQL 16

**Status:** Accepted (29 Oct 2026)

The SRS names PostgreSQL 16. This PC already runs PostgreSQL 18.6. PostGIS 3.6.2 publishes a PostgreSQL 18 Windows bundle, so a second server is not installed. Application SQL will target PostgreSQL 18.
