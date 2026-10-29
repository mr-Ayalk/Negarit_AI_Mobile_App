export const adwaPlaceholder = {
  source: 'placeholder-seed' as const,
  verified: false,
  note: 'The entrance has placeholder text that is not a reviewed museum source. Other zones have no story yet. Audio and beacon hardware are not loaded.',
  venue: {
    id: '11111111-1111-4111-8111-111111111111',
    slug: 'adwa-museum',
    name: { en: 'Adwa Museum', am: 'የአድዋ ሙዚየም' },
    timezone: 'Africa/Addis_Ababa',
    status: 'placeholder' as const,
  },
  zones: [
    {
      slug: 'entrance',
      type: 'entrance',
      name: { en: 'Entrance', am: 'መግቢያ' },
      content: [
        {
          language: 'en',
          body: 'Placeholder. This is not a reviewed museum source.',
          provenance: 'placeholder',
          status: 'placeholder',
        },
        {
          language: 'am',
          body: 'ይህ የተረጋገጠ የሙዚየም ጽሑፍ አይደለም።',
          provenance: 'placeholder',
          status: 'placeholder',
        },
      ],
    },
    {
      slug: '5gna-ber',
      type: 'exhibit',
      name: { en: '5gna Ber', am: '5ኛ ቤር' },
      content: [],
    },
    {
      slug: '6gna-ber',
      type: 'exhibit',
      name: { en: '6gna Ber', am: '6ኛ ቤር' },
      content: [],
    },
    {
      slug: 'coffee',
      type: 'facility',
      name: { en: 'Coffee', am: 'ቡና' },
      content: [],
    },
    {
      slug: 'restaurant',
      type: 'facility',
      name: { en: 'Restaurant', am: 'ምግብ ቤት' },
      content: [],
    },
    {
      slug: 'parking',
      type: 'facility',
      name: { en: 'Parking', am: 'ማቆሚያ' },
      content: [],
    },
    {
      slug: 'restrooms',
      type: 'facility',
      name: { en: 'Restrooms', am: 'መጸዳጃ' },
      content: [],
    },
    {
      slug: 'exits',
      type: 'facility',
      name: { en: 'Exits', am: 'መውጫ' },
      content: [],
    },
  ],
};
