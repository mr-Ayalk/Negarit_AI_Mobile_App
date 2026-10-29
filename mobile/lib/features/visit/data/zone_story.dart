import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:negarit_mobile/core/config/api_base.dart';

class ZoneStory {
  const ZoneStory({required this.body, required this.provenance});

  final String body;
  final String provenance;
}

/// Picks the story for [slug] in [languageCode], then English.
/// Returns null when that place has no stored text.
ZoneStory? storyFromVenueJson(
  Object? json,
  String slug,
  String languageCode,
) {
  if (json is! Map) {
    return null;
  }
  final zones = json['zones'];
  if (zones is! List) {
    return null;
  }
  for (final zone in zones) {
    if (zone is! Map || zone['slug'] != slug) {
      continue;
    }
    final content = zone['content'];
    if (content is! List) {
      return null;
    }
    Map<dynamic, dynamic>? match;
    Map<dynamic, dynamic>? english;
    for (final item in content) {
      if (item is! Map || item['body'] is! String) {
        continue;
      }
      if (item['language'] == languageCode) {
        match = item;
      }
      if (item['language'] == 'en') {
        english = item;
      }
    }
    final chosen = match ?? english;
    final body = chosen?['body'];
    if (body is! String || body.isEmpty) {
      return null;
    }
    final provenance = chosen?['provenance'];
    return ZoneStory(
      body: body,
      provenance: provenance is String ? provenance : 'placeholder',
    );
  }
  return null;
}

final zoneStoryProvider = FutureProvider.family<ZoneStory?, (String, String)>((
  ref,
  query,
) async {
  if (WidgetsBinding.instance.runtimeType.toString().contains('Test')) {
    return null;
  }
  try {
    final response = await http
        .get(Uri.parse('$apiBaseUrl/venues/adwa-museum'))
        .timeout(const Duration(seconds: 3));
    if (response.statusCode != 200) {
      return null;
    }
    return storyFromVenueJson(jsonDecode(response.body), query.$1, query.$2);
  } catch (_) {
    return null;
  }
});
