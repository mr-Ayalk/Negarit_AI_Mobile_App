import {
  Injectable,
  NotFoundException,
  ServiceUnavailableException,
} from '@nestjs/common';
import { databaseUrl } from '../config/env.js';
import { query } from '../database/database.js';
import { adwaPlaceholder } from './adwa-placeholder.js';

type VenueRow = {
  id: string;
  slug: string;
  name_en: string;
  name_am: string;
  timezone: string;
  status: string;
};

type ZoneRow = {
  slug: string;
  zone_type: string;
  name_en: string;
  name_am: string;
};

type ContentRow = {
  slug: string;
  status: string | null;
  language: string | null;
  body: string | null;
  provenance: string | null;
};

@Injectable()
export class VenuesService {
  async list() {
    if (!databaseUrl()) {
      return {
        source: adwaPlaceholder.source,
        verified: adwaPlaceholder.verified,
        venues: [adwaPlaceholder.venue],
      };
    }

    try {
      const result = await query<VenueRow>(
        `SELECT id::text, slug, name_en, name_am, timezone, status
         FROM venues
         ORDER BY slug`,
      );
      return {
        source: 'database' as const,
        verified: false,
        venues: result.rows.map(toVenue),
      };
    } catch {
      throw new ServiceUnavailableException(
        'The database is configured, but the venue query failed. Run scripts/apply-db.ps1.',
      );
    }
  }

  async findBySlug(slug: string) {
    if (!databaseUrl()) {
      if (slug !== adwaPlaceholder.venue.slug) {
        throw new NotFoundException(`No venue is loaded for ${slug}.`);
      }
      return adwaPlaceholder;
    }

    try {
      const venues = await query<VenueRow>(
        `SELECT id::text, slug, name_en, name_am, timezone, status
         FROM venues
         WHERE slug = $1`,
        [slug],
      );
      const venue = venues.rows[0];
      if (!venue) {
        throw new NotFoundException(`No venue is loaded for ${slug}.`);
      }
      const zones = await query<ZoneRow>(
        `SELECT slug, zone_type, name_en, name_am
         FROM zones
         WHERE venue_id = $1
         ORDER BY sort_order`,
        [venue.id],
      );
      const content = await query<ContentRow>(
        `SELECT z.slug, ci.status, ct.language, ct.body, ct.provenance
         FROM zones z
         LEFT JOIN content_items ci ON ci.zone_id = z.id
         LEFT JOIN content_translations ct ON ct.content_id = ci.id
         WHERE z.venue_id = $1`,
        [venue.id],
      );
      return {
        source: 'database' as const,
        verified: false,
        note: 'Loaded from the database. Museum stories are still placeholder text until they are reviewed.',
        venue: toVenue(venue),
        zones: zones.rows.map((zone: ZoneRow) => ({
          slug: zone.slug,
          type: zone.zone_type,
          name: { en: zone.name_en, am: zone.name_am },
          content: contentFor(content.rows, zone.slug),
        })),
      };
    } catch (error) {
      if (error instanceof NotFoundException) {
        throw error;
      }
      throw new ServiceUnavailableException(
        'The database is configured, but the venue query failed. Run scripts/apply-db.ps1.',
      );
    }
  }
}

function contentFor(rows: ContentRow[], slug: string) {
  return rows
    .filter(
      (row) =>
        row.slug === slug &&
        row.language !== null &&
        row.body !== null &&
        row.provenance !== null,
    )
    .map((row) => ({
      language: row.language,
      body: row.body,
      provenance: row.provenance,
      status: row.status ?? 'placeholder',
    }));
}

function toVenue(row: VenueRow) {
  return {
    id: row.id,
    slug: row.slug,
    name: { en: row.name_en, am: row.name_am },
    timezone: row.timezone,
    status: row.status,
  };
}
