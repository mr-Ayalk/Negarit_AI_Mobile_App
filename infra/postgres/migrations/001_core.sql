-- Core tables for the visitor journey.
-- Geography and vector columns wait until CREATE EXTENSION has been verified.
-- Apply with scripts/apply-db.ps1. Do not put passwords in this file.

CREATE TABLE IF NOT EXISTS venues (
  id uuid PRIMARY KEY,
  slug text NOT NULL UNIQUE,
  name_en text NOT NULL,
  name_am text NOT NULL,
  latitude double precision,
  longitude double precision,
  timezone text NOT NULL DEFAULT 'Africa/Addis_Ababa',
  status text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS zones (
  id uuid PRIMARY KEY,
  venue_id uuid NOT NULL REFERENCES venues (id),
  slug text NOT NULL,
  zone_type text NOT NULL,
  name_en text NOT NULL,
  name_am text NOT NULL,
  sort_order integer NOT NULL,
  UNIQUE (venue_id, slug)
);

CREATE TABLE IF NOT EXISTS beacons (
  id uuid PRIMARY KEY,
  venue_id uuid NOT NULL REFERENCES venues (id),
  zone_id uuid NOT NULL REFERENCES zones (id),
  protocol text NOT NULL,
  uuid text NOT NULL,
  major integer NOT NULL,
  minor integer NOT NULL,
  status text NOT NULL
);

CREATE TABLE IF NOT EXISTS content_items (
  id uuid PRIMARY KEY,
  zone_id uuid NOT NULL REFERENCES zones (id),
  content_type text NOT NULL,
  base_language text NOT NULL,
  status text NOT NULL
);

CREATE TABLE IF NOT EXISTS content_translations (
  id uuid PRIMARY KEY,
  content_id uuid NOT NULL REFERENCES content_items (id),
  language text NOT NULL,
  body text NOT NULL,
  provenance text NOT NULL,
  UNIQUE (content_id, language)
);

CREATE TABLE IF NOT EXISTS merchants (
  id uuid PRIMARY KEY,
  venue_id uuid NOT NULL REFERENCES venues (id),
  name text NOT NULL,
  status text NOT NULL
);

CREATE TABLE IF NOT EXISTS offers (
  id uuid PRIMARY KEY,
  merchant_id uuid NOT NULL REFERENCES merchants (id),
  title_en text NOT NULL,
  title_am text NOT NULL,
  price_etb numeric(12, 2),
  is_sponsored boolean NOT NULL DEFAULT false,
  status text NOT NULL
);
