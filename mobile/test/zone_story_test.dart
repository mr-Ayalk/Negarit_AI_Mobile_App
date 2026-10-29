import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/features/visit/data/zone_story.dart';

void main() {
  const venue = {
    'zones': [
      {
        'slug': 'entrance',
        'content': [
          {
            'language': 'en',
            'body': 'Placeholder. This is not a reviewed museum source.',
            'provenance': 'placeholder',
          },
          {
            'language': 'am',
            'body': 'ይህ የተረጋገጠ የሙዚየም ጽሑፍ አይደለም።',
            'provenance': 'placeholder',
          },
        ],
      },
      {'slug': 'coffee', 'content': []},
    ],
  };

  test('uses the stored language and does not invent a missing story', () {
    expect(
      storyFromVenueJson(venue, 'entrance', 'am')?.body,
      'ይህ የተረጋገጠ የሙዚየም ጽሑፍ አይደለም።',
    );
    expect(
      storyFromVenueJson(venue, 'entrance', 'ar')?.body,
      'Placeholder. This is not a reviewed museum source.',
    );
    expect(storyFromVenueJson(venue, 'coffee', 'en'), isNull);
  });
}
