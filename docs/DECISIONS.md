# Decisions

Short architecture decision records. The newest entry is at the top.

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
