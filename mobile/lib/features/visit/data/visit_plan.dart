import 'package:negarit_mobile/features/visit/data/visit_places.dart';

/// Visit order for Adwa. Entrance first, then matching places, then the exits.
/// An empty interest list uses the two halls. This is not a measured route.
List<VisitPlace> visitPlan(Iterable<String> interests) {
  final chosen = placesForInterests(interests);
  final middle = chosen.isEmpty
      ? <VisitPlace>[
          placeBySlug('5gna-ber')!,
          placeBySlug('6gna-ber')!,
        ]
      : chosen;
  return <VisitPlace>[
    placeBySlug('entrance')!,
    ...middle,
    placeBySlug('exits')!,
  ];
}
