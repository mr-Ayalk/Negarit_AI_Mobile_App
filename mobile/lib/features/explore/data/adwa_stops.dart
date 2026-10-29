import 'package:negarit_mobile/features/visit/data/visit_places.dart';

/// English names for the planned Adwa areas.
/// They match infra/postgres/seed/001_adwa.sql. Stories are not included.
final adwaStopNames = <String>[
  for (final place in adwaPlaces) place.nameEn,
];
