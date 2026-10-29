import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

String interestLabel(AppLocalizations l10n, String interestId) {
  switch (interestId) {
    case 'halls':
      return l10n.interestHalls;
    case 'coffee':
      return l10n.interestCoffee;
    case 'food':
      return l10n.interestFood;
    case 'parking':
      return l10n.interestParking;
    case 'restrooms':
      return l10n.interestRestrooms;
    default:
      return interestId;
  }
}

String placeTypeLabel(AppLocalizations l10n, VisitPlace place) {
  switch (place.type) {
    case 'entrance':
      return l10n.placeTypeEntrance;
    case 'exhibit':
      return l10n.placeTypeHall;
    default:
      return l10n.placeTypeFacility;
  }
}
