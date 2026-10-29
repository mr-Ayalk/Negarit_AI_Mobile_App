# Changelog

All notable changes to Negarit AI are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Visitor map shows Adwa 00KM Museum on Google Maps, with the indoor visit schematic still available.
- API reads venues from `DATABASE_URL` when it is set, starts a Chapa checkout when the secret is set, and keeps Telebirr and AI labeled as demo.
- Adwa placeholder venue, zones, and a SQL schema. Apply it with `scripts/apply-db.ps1` after `DATABASE_URL` is in `.env`.
- Visitor screens use the sky-gradient layout: explore, floor-plan map, favorites, profile, and an unconnected guide.
- Windows notes for installing a debug build on an Android phone.
- Extracted SRS v2.0 into `docs/SRS.md`.
- Windows toolchain guide and `scripts/check-env.ps1`.
- Proprietary license, ignore rules, and environment template.
- Flutter visitor shell with theme tokens, bundled fonts, and English, Amharic, and Arabic strings.
- NestJS API with `GET /health`, OpenAPI at `/docs`, and empty feature modules.
- Next.js admin scaffold, GitHub Actions CI, and the Postgres extension script.
