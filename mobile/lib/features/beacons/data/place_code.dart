import 'package:negarit_mobile/features/visit/data/visit_places.dart';

final _placeUri = RegExp(r'^negarit://place/([a-z0-9-]+)/?$');
final _venueUri = RegExp(r'^negarit:adwa-museum:([a-z0-9-]+)$');
final _slug = RegExp(r'^[a-z0-9-]+$');

/// Reads a place from typed text or the payload a printed QR would carry.
/// The camera does not scan, and NFC is not read.
String? placeSlugFromCode(String raw) {
  final text = raw.trim();
  if (text.isEmpty) {
    return null;
  }
  final compact = text.toLowerCase();
  final fromUri =
      _placeUri.firstMatch(compact)?.group(1) ??
      _venueUri.firstMatch(compact)?.group(1);
  if (fromUri != null) {
    return placeBySlug(fromUri)?.slug;
  }
  if (_slug.hasMatch(compact)) {
    return placeBySlug(compact)?.slug;
  }
  for (final place in adwaPlaces) {
    if (place.nameEn.toLowerCase() == compact || place.nameAm == text) {
      return place.slug;
    }
  }
  return null;
}
