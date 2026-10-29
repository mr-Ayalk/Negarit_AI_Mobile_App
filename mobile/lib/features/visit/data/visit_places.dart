/// The eight Adwa places. Names match infra/postgres/seed/001_adwa.sql.
/// Stories and audio are not included.
class VisitPlace {
  const VisitPlace({
    required this.slug,
    required this.type,
    required this.nameEn,
    required this.nameAm,
    this.interest,
  });

  final String slug;
  final String type;
  final String nameEn;
  final String nameAm;

  /// Profile interest that highlights this place. Entrance and exits have none.
  final String? interest;

  String nameFor(String languageCode) {
    if (languageCode == 'am') {
      return nameAm;
    }
    return nameEn;
  }
}

const adwaPlaces = <VisitPlace>[
  VisitPlace(
    slug: 'entrance',
    type: 'entrance',
    nameEn: 'Entrance',
    nameAm: 'መግቢያ',
  ),
  VisitPlace(
    slug: '5gna-ber',
    type: 'exhibit',
    nameEn: '5gna Ber',
    nameAm: '5ኛ ቤር',
    interest: 'halls',
  ),
  VisitPlace(
    slug: '6gna-ber',
    type: 'exhibit',
    nameEn: '6gna Ber',
    nameAm: '6ኛ ቤር',
    interest: 'halls',
  ),
  VisitPlace(
    slug: 'coffee',
    type: 'facility',
    nameEn: 'Coffee',
    nameAm: 'ቡና',
    interest: 'coffee',
  ),
  VisitPlace(
    slug: 'restaurant',
    type: 'facility',
    nameEn: 'Restaurant',
    nameAm: 'ምግብ ቤት',
    interest: 'food',
  ),
  VisitPlace(
    slug: 'parking',
    type: 'facility',
    nameEn: 'Parking',
    nameAm: 'ማቆሚያ',
    interest: 'parking',
  ),
  VisitPlace(
    slug: 'restrooms',
    type: 'facility',
    nameEn: 'Restrooms',
    nameAm: 'መጸዳጃ',
    interest: 'restrooms',
  ),
  VisitPlace(
    slug: 'exits',
    type: 'facility',
    nameEn: 'Exits',
    nameAm: 'መውጫ',
  ),
];

const visitInterestIds = <String>[
  'halls',
  'coffee',
  'food',
  'parking',
  'restrooms',
];

VisitPlace? placeBySlug(String slug) {
  for (final place in adwaPlaces) {
    if (place.slug == slug) {
      return place;
    }
  }
  return null;
}

List<VisitPlace> placesForInterests(Iterable<String> interests) {
  final selected = interests.toSet();
  return adwaPlaces
      .where((place) => place.interest != null && selected.contains(place.interest))
      .toList();
}
