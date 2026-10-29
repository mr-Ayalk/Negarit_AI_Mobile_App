/// Foreground zone rules for a visit. This does not scan Bluetooth.
class RssiSample {
  const RssiSample({
    required this.zoneSlug,
    required this.rssi,
    required this.at,
  });

  final String zoneSlug;
  final int rssi;
  final DateTime at;
}

enum ZoneChange { entered, exited, cooled }

class ZoneChangeEvent {
  const ZoneChangeEvent({
    required this.zoneSlug,
    required this.change,
    required this.source,
  });

  final String zoneSlug;
  final ZoneChange change;

  /// `simulated` for a fed signal, `manual` for a place the visitor picked.
  final String source;
}

class BeaconEngine {
  BeaconEngine({
    this.enterRssi = -70,
    this.exitRssi = -82,
    this.minDwell = const Duration(seconds: 3),
    this.cooldown = const Duration(minutes: 5),
    this.smoothCount = 3,
  });

  final int enterRssi;
  final int exitRssi;
  final Duration minDwell;
  final Duration cooldown;
  final int smoothCount;

  final Map<String, List<int>> _windows = {};
  final Map<String, DateTime> _stableSince = {};
  final Map<String, DateTime> _announcedAt = {};
  String? currentZone;

  ZoneChangeEvent? ingest(RssiSample sample) {
    final window = _windows.putIfAbsent(sample.zoneSlug, () => <int>[]);
    window.add(sample.rssi);
    if (window.length > smoothCount) {
      window.removeAt(0);
    }

    final level = _smoothed(sample.zoneSlug);
    if (level != null && level >= enterRssi) {
      _stableSince.putIfAbsent(sample.zoneSlug, () => sample.at);
    } else {
      _stableSince.remove(sample.zoneSlug);
    }

    ZoneChangeEvent? left;
    if (currentZone != null) {
      final currentLevel = _smoothed(currentZone!);
      if (currentLevel != null && currentLevel < exitRssi) {
        final slug = currentZone!;
        currentZone = null;
        left = ZoneChangeEvent(
          zoneSlug: slug,
          change: ZoneChange.exited,
          source: 'simulated',
        );
      }
    }

    final winner = _winner(sample.at);
    if (winner == null || winner == currentZone) {
      return left;
    }
    if (_cooling(winner, sample.at)) {
      return ZoneChangeEvent(
        zoneSlug: winner,
        change: ZoneChange.cooled,
        source: 'simulated',
      );
    }
    currentZone = winner;
    _announcedAt[winner] = sample.at;
    return ZoneChangeEvent(
      zoneSlug: winner,
      change: ZoneChange.entered,
      source: 'simulated',
    );
  }

  ZoneChangeEvent choose(String zoneSlug, DateTime at) {
    if (_cooling(zoneSlug, at)) {
      return ZoneChangeEvent(
        zoneSlug: zoneSlug,
        change: ZoneChange.cooled,
        source: 'manual',
      );
    }
    currentZone = zoneSlug;
    _announcedAt[zoneSlug] = at;
    return ZoneChangeEvent(
      zoneSlug: zoneSlug,
      change: ZoneChange.entered,
      source: 'manual',
    );
  }

  int? _smoothed(String slug) {
    final window = _windows[slug];
    if (window == null || window.isEmpty) {
      return null;
    }
    final sum = window.reduce((total, value) => total + value);
    return sum ~/ window.length;
  }

  String? _winner(DateTime at) {
    String? best;
    var bestLevel = -9999;
    for (final entry in _stableSince.entries) {
      if (at.difference(entry.value) < minDwell) {
        continue;
      }
      final level = _smoothed(entry.key);
      if (level == null || level < enterRssi || level <= bestLevel) {
        continue;
      }
      best = entry.key;
      bestLevel = level;
    }
    return best;
  }

  bool _cooling(String slug, DateTime at) {
    final last = _announcedAt[slug];
    if (last == null) {
      return false;
    }
    return at.difference(last) < cooldown;
  }
}

String visitorLabel(String? destination, String guest) {
  final trimmed = destination?.trim() ?? '';
  if (trimmed.isEmpty) {
    return guest;
  }
  final at = trimmed.indexOf('@');
  if (at > 1) {
    return trimmed.substring(0, at);
  }
  return trimmed;
}
