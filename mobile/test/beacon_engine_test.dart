import 'package:flutter_test/flutter_test.dart';
import 'package:negarit_mobile/features/beacons/data/beacon_engine.dart';

void main() {
  final start = DateTime(2026, 10, 29, 12);

  RssiSample sample(String slug, int rssi, Duration offset) {
    return RssiSample(zoneSlug: slug, rssi: rssi, at: start.add(offset));
  }

  test('enters after the signal stays strong through the dwell time', () {
    final engine = BeaconEngine();

    expect(engine.ingest(sample('entrance', -60, Duration.zero)), isNull);
    expect(
      engine.ingest(sample('entrance', -60, const Duration(seconds: 2))),
      isNull,
    );

    final entered = engine.ingest(
      sample('entrance', -60, const Duration(seconds: 3)),
    );

    expect(entered?.change, ZoneChange.entered);
    expect(entered?.source, 'simulated');
    expect(engine.currentZone, 'entrance');
  });

  test('a reading inside the hysteresis band does not leave the place', () {
    final engine = BeaconEngine();
    engine.ingest(sample('entrance', -60, Duration.zero));
    engine.ingest(sample('entrance', -60, const Duration(seconds: 3)));

    engine.ingest(sample('entrance', -78, const Duration(seconds: 4)));
    final stayed = engine.ingest(
      sample('entrance', -78, const Duration(seconds: 5)),
    );

    expect(stayed, isNull);
    expect(engine.currentZone, 'entrance');
  });

  test('leaves after the smoothed signal falls below the exit threshold', () {
    final engine = BeaconEngine();
    engine.ingest(sample('entrance', -60, Duration.zero));
    engine.ingest(sample('entrance', -60, const Duration(seconds: 3)));

    engine.ingest(sample('entrance', -95, const Duration(seconds: 4)));
    final left = engine.ingest(
      sample('entrance', -95, const Duration(seconds: 5)),
    );

    expect(left?.change, ZoneChange.exited);
    expect(engine.currentZone, isNull);
  });

  test('the stronger stable signal replaces the current place', () {
    final engine = BeaconEngine();
    engine.ingest(sample('5gna-ber', -65, Duration.zero));
    engine.ingest(sample('5gna-ber', -65, const Duration(seconds: 3)));
    expect(engine.currentZone, '5gna-ber');

    engine.ingest(sample('6gna-ber', -50, const Duration(seconds: 4)));
    final replaced = engine.ingest(
      sample('6gna-ber', -50, const Duration(seconds: 7)),
    );

    expect(replaced?.zoneSlug, '6gna-ber');
    expect(replaced?.change, ZoneChange.entered);
    expect(engine.currentZone, '6gna-ber');
  });

  test('does not announce the same place again during the cooldown', () {
    final engine = BeaconEngine();

    final first = engine.choose('5gna-ber', start);
    final again = engine.choose(
      '5gna-ber',
      start.add(const Duration(minutes: 1)),
    );
    final later = engine.choose(
      '5gna-ber',
      start.add(const Duration(minutes: 5)),
    );

    expect(first.change, ZoneChange.entered);
    expect(again.change, ZoneChange.cooled);
    expect(engine.currentZone, '5gna-ber');
    expect(later.change, ZoneChange.entered);
  });

  test('uses the mailbox name when the visitor signed in with an email', () {
    expect(visitorLabel('visitor@example.com', 'Guest'), 'visitor');
    expect(visitorLabel(null, 'Guest'), 'Guest');
  });
}
