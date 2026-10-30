export type VenueStory = {
  language: string;
  body: string;
  provenance: string;
  status: string;
};

export type VenueZone = {
  slug: string;
  type: string;
  nameEn: string;
  nameAm: string;
  stories: VenueStory[];
};

export type VenueRecord = {
  source: string;
  verified: boolean;
  note: string;
  slug: string;
  nameEn: string;
  nameAm: string;
  status: string;
  timezone: string;
  zones: VenueZone[];
};

export type VenueLoad =
  | { ok: true; venue: VenueRecord }
  | { ok: false; reason: "unreachable" | "unreadable" };

function storyFromJson(value: unknown): VenueStory | null {
  if (typeof value !== "object" || value === null) {
    return null;
  }
  const story = value as Record<string, unknown>;
  if (
    typeof story.language !== "string" ||
    typeof story.body !== "string" ||
    typeof story.provenance !== "string" ||
    typeof story.status !== "string"
  ) {
    return null;
  }
  return {
    language: story.language,
    body: story.body,
    provenance: story.provenance,
    status: story.status,
  };
}

function zoneFromJson(value: unknown): VenueZone | null {
  if (typeof value !== "object" || value === null) {
    return null;
  }
  const zone = value as Record<string, unknown>;
  const name = zone.name;
  if (
    typeof zone.slug !== "string" ||
    typeof zone.type !== "string" ||
    typeof name !== "object" ||
    name === null ||
    !Array.isArray(zone.content)
  ) {
    return null;
  }
  const names = name as Record<string, unknown>;
  if (typeof names.en !== "string" || typeof names.am !== "string") {
    return null;
  }
  const stories: VenueStory[] = [];
  for (const item of zone.content) {
    const story = storyFromJson(item);
    if (!story) {
      return null;
    }
    stories.push(story);
  }
  return {
    slug: zone.slug,
    type: zone.type,
    nameEn: names.en,
    nameAm: names.am,
    stories,
  };
}

/** Reads the public venue response. Returns null when the shape is not the API's. */
export function venueFromJson(value: unknown): VenueRecord | null {
  if (typeof value !== "object" || value === null) {
    return null;
  }
  const body = value as Record<string, unknown>;
  const venue = body.venue;
  if (
    typeof body.source !== "string" ||
    typeof body.verified !== "boolean" ||
    typeof body.note !== "string" ||
    typeof venue !== "object" ||
    venue === null ||
    !Array.isArray(body.zones)
  ) {
    return null;
  }
  const record = venue as Record<string, unknown>;
  const name = record.name;
  if (
    typeof record.slug !== "string" ||
    typeof record.status !== "string" ||
    typeof record.timezone !== "string" ||
    typeof name !== "object" ||
    name === null
  ) {
    return null;
  }
  const names = name as Record<string, unknown>;
  if (typeof names.en !== "string" || typeof names.am !== "string") {
    return null;
  }
  const zones: VenueZone[] = [];
  for (const item of body.zones) {
    const zone = zoneFromJson(item);
    if (!zone) {
      return null;
    }
    zones.push(zone);
  }
  return {
    source: body.source,
    verified: body.verified,
    note: body.note,
    slug: record.slug,
    nameEn: names.en,
    nameAm: names.am,
    status: record.status,
    timezone: record.timezone,
    zones,
  };
}

const apiBase = process.env.ADMIN_API_BASE?.trim() || "http://127.0.0.1:3000";

export async function loadAdwaVenue(): Promise<VenueLoad> {
  try {
    const response = await fetch(`${apiBase}/venues/adwa-museum`, {
      cache: "no-store",
      signal: AbortSignal.timeout(3000),
    });
    if (!response.ok) {
      return { ok: false, reason: "unreachable" };
    }
    const venue = venueFromJson(await response.json());
    if (!venue) {
      return { ok: false, reason: "unreadable" };
    }
    return { ok: true, venue };
  } catch {
    return { ok: false, reason: "unreachable" };
  }
}
