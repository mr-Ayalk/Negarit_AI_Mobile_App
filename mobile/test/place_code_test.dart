import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/features/beacons/data/place_code.dart';

void main() {
  test('reads a place slug', () {
    expect(placeSlugFromCode('coffee'), 'coffee');
    expect(placeSlugFromCode(' 5gna-ber '), '5gna-ber');
  });

  test('reads the text a printed QR would carry', () {
    expect(placeSlugFromCode('negarit://place/parking'), 'parking');
    expect(placeSlugFromCode('negarit:adwa-museum:exits'), 'exits');
  });

  test('reads the place name', () {
    expect(placeSlugFromCode('Coffee'), 'coffee');
    expect(placeSlugFromCode('ቡና'), 'coffee');
  });

  test('rejects a code that is not on this visit', () {
    expect(placeSlugFromCode(''), isNull);
    expect(placeSlugFromCode('lobby'), isNull);
    expect(placeSlugFromCode('negarit://place/lobby'), isNull);
    expect(placeSlugFromCode('negarit://place/coffee?extra=1'), isNull);
  });
}
