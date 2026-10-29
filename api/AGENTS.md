# API agent notes

This service is the Negarit AI modular monolith. Product rules live in the repository root `AGENTS.md`.

NestJS Observe is not enabled. Do not add `ObserveModule` or write `OBSERVE_APP_KEY` / `OBSERVE_APP_SECRET` into a committed file. Telemetry can be added later behind environment variables.

`GET /health` is the liveness check. OpenAPI is served at `/docs` when the process is running.

Lint with `npm run lint` (oxlint, the Nest 12 default). Test with `npm test` and `npm run test:e2e`.
