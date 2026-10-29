import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/features/beacons/data/beacon_engine.dart';

class PresenceNotice {
  const PresenceNotice({required this.zoneSlug, required this.kind});

  final String zoneSlug;

  /// `welcome` once at the entrance, `here` for a later place, `cooldown` when
  /// the same place was announced within the last five minutes.
  final String kind;
}

class PresenceController extends Notifier<PresenceNotice?> {
  final _engine = BeaconEngine();
  var _welcomed = false;

  @override
  PresenceNotice? build() => null;

  void choose(String zoneSlug) {
    final event = _engine.choose(zoneSlug, DateTime.now());
    if (event.change == ZoneChange.cooled) {
      state = PresenceNotice(zoneSlug: zoneSlug, kind: 'cooldown');
      return;
    }
    if (zoneSlug == 'entrance' && !_welcomed) {
      _welcomed = true;
      state = PresenceNotice(zoneSlug: zoneSlug, kind: 'welcome');
      return;
    }
    state = PresenceNotice(zoneSlug: zoneSlug, kind: 'here');
  }
}

final presenceProvider = NotifierProvider<PresenceController, PresenceNotice?>(
  PresenceController.new,
);
