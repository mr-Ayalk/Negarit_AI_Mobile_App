-- Run as a PostgreSQL superuser after PostGIS and pgvector files are installed.
-- Do not put the superuser password in this file.

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS vector;

SELECT extname, extversion
FROM pg_extension
WHERE extname IN ('postgis', 'vector');
