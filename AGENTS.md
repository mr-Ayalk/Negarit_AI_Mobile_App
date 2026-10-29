# Agent guide

Negarit AI is a commercial visitor companion for museums and venues, starting with Adwa Museum. Launch target: 31 Oct 2026.

## Source of truth

- Product behavior: `docs/SRS.md` (extracted from `Negarit_AI_SRS_v2.pdf`).
- Process and honesty rules in this file override the SRS when they disagree.
- Record ambiguous product choices in `docs/DECISIONS.md`.
- Keep `docs/STATUS.md` accurate: Verified, Simulated, or Not started.

## Rules

- Plan a phase before editing. After the phase, report what is done, how it was tested, what is not done, and what is next.
- Do not claim a feature works unless it was run. Simulated beacons, payments, and speech stay behind flags and are labeled in the UI.
- Never commit secrets. Use `.env` (ignored) and `.env.example`.
- Do not delete or overwrite existing work you did not create.
- Windows, PowerShell, and paths that contain spaces. Do not install Android Studio.
- Small commits with Conventional Commits. One logical change per commit.
- The license stays proprietary until the maintainer chooses otherwise.
- PostgreSQL 18 is the local database. Do not add Docker Desktop on this PC.
- AI keys, payment secrets, and the PostgreSQL superuser password stay out of git and out of the mobile app.

## Build order

1. Environment and `scripts/check-env.ps1`.
2. Monorepo: `mobile` (Flutter), `api` (NestJS), `admin` (web), `infra`, `docs`.
3. P0 visitor journey before P1, and P1 before P2. Cut P2 first when time runs out.
4. 31 Oct is for testing, fixes, and release only.

## Defaults already chosen

See `docs/DECISIONS.md`: proprietary license, PostgreSQL 18, no Docker, mock AI, floor-plan map, OTP printed in the API log, community pgvector binary until `CREATE EXTENSION` is verified.
