export type GuideKind = 'place' | 'halls' | 'overview' | 'unknown';

export interface GuideAnswer {
  provider: 'mock';
  verified: false;
  source: 'visit-list';
  kind: GuideKind;
  placeSlug: string | null;
}

const places: ReadonlyArray<{ key: string; slug: string }> = [
  { key: 'entrance', slug: 'entrance' },
  { key: 'መግቢያ', slug: 'entrance' },
  { key: '5gna', slug: '5gna-ber' },
  { key: '5ኛ', slug: '5gna-ber' },
  { key: '6gna', slug: '6gna-ber' },
  { key: '6ኛ', slug: '6gna-ber' },
  { key: 'coffee', slug: 'coffee' },
  { key: 'ቡና', slug: 'coffee' },
  { key: 'restaurant', slug: 'restaurant' },
  { key: 'ምግብ', slug: 'restaurant' },
  { key: 'parking', slug: 'parking' },
  { key: 'ማቆሚያ', slug: 'parking' },
  { key: 'restroom', slug: 'restrooms' },
  { key: 'toilet', slug: 'restrooms' },
  { key: 'መጸዳጃ', slug: 'restrooms' },
  { key: 'exit', slug: 'exits' },
  { key: 'መውጫ', slug: 'exits' },
];

function answer(kind: GuideKind, placeSlug: string | null = null): GuideAnswer {
  return {
    provider: 'mock',
    verified: false,
    source: 'visit-list',
    kind,
    placeSlug,
  };
}

/**
 * Classifies a question against the eight Adwa places.
 * It does not call a language model and does not invent museum facts.
 */
export function answerVisit(question: string): GuideAnswer {
  const asked = question.trim().toLowerCase();
  if (!asked) {
    return answer('unknown');
  }
  if (asked.includes('hall') || asked.includes('ቤር')) {
    return answer('halls');
  }
  for (const place of places) {
    if (asked.includes(place.key)) {
      return answer('place', place.slug);
    }
  }
  if (
    asked.includes('visit') ||
    asked.includes('route') ||
    asked.includes('ጉብኝት')
  ) {
    return answer('overview');
  }
  return answer('unknown');
}
