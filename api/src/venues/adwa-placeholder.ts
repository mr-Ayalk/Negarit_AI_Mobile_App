export const adwaPlaceholder = {
  source: 'placeholder-seed' as const,
  verified: false,
  note: 'Zone names follow the planned Adwa layout. Stories, audio, coordinates, and beacon hardware are not loaded.',
  venue: {
    id: '11111111-1111-4111-8111-111111111111',
    slug: 'adwa-museum',
    name: { en: 'Adwa Museum', am: 'የአድዋ ሙዚየም' },
    timezone: 'Africa/Addis_Ababa',
    status: 'placeholder' as const,
  },
  zones: [
    { slug: 'entrance', type: 'entrance', name: { en: 'Entrance', am: 'መግቢያ' } },
    { slug: '5gna-ber', type: 'exhibit', name: { en: '5gna Ber', am: '5ኛ ቤር' } },
    { slug: '6gna-ber', type: 'exhibit', name: { en: '6gna Ber', am: '6ኛ ቤር' } },
    { slug: 'coffee', type: 'facility', name: { en: 'Coffee', am: 'ቡና' } },
    { slug: 'restaurant', type: 'facility', name: { en: 'Restaurant', am: 'ምግብ ቤት' } },
    { slug: 'parking', type: 'facility', name: { en: 'Parking', am: 'ማቆሚያ' } },
    { slug: 'restrooms', type: 'facility', name: { en: 'Restrooms', am: 'መጸዳጃ' } },
    { slug: 'exits', type: 'facility', name: { en: 'Exits', am: 'መውጫ' } },
  ],
};
