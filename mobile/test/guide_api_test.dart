import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/features/guide/data/guide_api.dart';

void main() {
  test('reads a mock visit-list answer', () {
    final answer = guideAnswerFromJson({
      'provider': 'mock',
      'verified': false,
      'source': 'visit-list',
      'kind': 'place',
      'placeSlug': 'coffee',
    });

    expect(answer?.kind, 'place');
    expect(answer?.placeSlug, 'coffee');
  });

  test('rejects an answer that is not a known kind', () {
    expect(guideAnswerFromJson({'kind': 'story', 'placeSlug': 'coffee'}), isNull);
  });
}
