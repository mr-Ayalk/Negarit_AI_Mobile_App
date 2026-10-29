-- Placeholder Adwa layout. Zone names follow the planned visitor journey.
-- Stories are not reviewed museum sources. Beacon IDs are not installed hardware.

INSERT INTO venues (id, slug, name_en, name_am, timezone, status)
VALUES (
  '11111111-1111-4111-8111-111111111111',
  'adwa-museum',
  'Adwa Museum',
  'የአድዋ ሙዚየም',
  'Africa/Addis_Ababa',
  'placeholder'
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO zones (id, venue_id, slug, zone_type, name_en, name_am, sort_order)
VALUES
  ('22222222-2222-4222-8222-222222222201', '11111111-1111-4111-8111-111111111111', 'entrance', 'entrance', 'Entrance', 'መግቢያ', 1),
  ('22222222-2222-4222-8222-222222222202', '11111111-1111-4111-8111-111111111111', '5gna-ber', 'exhibit', '5gna Ber', '5ኛ ቤር', 2),
  ('22222222-2222-4222-8222-222222222203', '11111111-1111-4111-8111-111111111111', '6gna-ber', 'exhibit', '6gna Ber', '6ኛ ቤር', 3),
  ('22222222-2222-4222-8222-222222222204', '11111111-1111-4111-8111-111111111111', 'coffee', 'facility', 'Coffee', 'ቡና', 4),
  ('22222222-2222-4222-8222-222222222205', '11111111-1111-4111-8111-111111111111', 'restaurant', 'facility', 'Restaurant', 'ምግብ ቤት', 5),
  ('22222222-2222-4222-8222-222222222206', '11111111-1111-4111-8111-111111111111', 'parking', 'facility', 'Parking', 'ማቆሚያ', 6),
  ('22222222-2222-4222-8222-222222222207', '11111111-1111-4111-8111-111111111111', 'restrooms', 'facility', 'Restrooms', 'መጸዳጃ', 7),
  ('22222222-2222-4222-8222-222222222208', '11111111-1111-4111-8111-111111111111', 'exits', 'facility', 'Exits', 'መውጫ', 8)
ON CONFLICT (venue_id, slug) DO NOTHING;

INSERT INTO content_items (id, zone_id, content_type, base_language, status)
VALUES (
  '33333333-3333-4333-8333-333333333301',
  '22222222-2222-4222-8222-222222222201',
  'story',
  'en',
  'placeholder'
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO content_translations (id, content_id, language, body, provenance)
VALUES
  (
    '44444444-4444-4444-8444-444444444401',
    '33333333-3333-4333-8333-333333333301',
    'en',
    'Placeholder. This is not a reviewed museum source.',
    'placeholder'
  ),
  (
    '44444444-4444-4444-8444-444444444402',
    '33333333-3333-4333-8333-333333333301',
    'am',
    'ይህ የተረጋገጠ የሙዚየም ጽሑፍ አይደለም።',
    'placeholder'
  )
ON CONFLICT (content_id, language) DO NOTHING;
