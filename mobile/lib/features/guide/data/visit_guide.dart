import 'package:negarit_mobile/features/guide/data/guide_api.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

/// Answers from the Adwa places stored on the phone.
String replyForVisit(String question, AppLocalizations l10n) {
  final asked = question.toLowerCase();
  const places = <String, String>{
    'entrance': 'Entrance',
    'መግቢያ': 'Entrance',
    '5gna': '5gna Ber',
    '5ኛ': '5gna Ber',
    '6gna': '6gna Ber',
    '6ኛ': '6gna Ber',
    'coffee': 'Coffee',
    'ቡና': 'Coffee',
    'restaurant': 'Restaurant',
    'ምግብ': 'Restaurant',
    'parking': 'Parking',
    'ማቆሚያ': 'Parking',
    'restroom': 'Restrooms',
    'toilet': 'Restrooms',
    'መጸዳጃ': 'Restrooms',
    'exit': 'Exits',
    'መውጫ': 'Exits',
  };

  if (asked.contains('hall') || asked.contains('ቤር')) {
    return l10n.guideHallsReply;
  }

  for (final place in places.entries) {
    if (asked.contains(place.key)) {
      return l10n.guideStopReply(place.value);
    }
  }
  if (asked.contains('visit') ||
      asked.contains('route') ||
      asked.contains('ጉብኝት')) {
    return l10n.guideReply;
  }
  return l10n.guideUnknown;
}

/// Sentence for a guide-service answer, in the visitor's language.
String textForGuideAnswer(
  GuideAnswer answer,
  AppLocalizations l10n,
  String languageCode,
) {
  switch (answer.kind) {
    case 'halls':
      return l10n.guideHallsReply;
    case 'overview':
      return l10n.guideReply;
    case 'place':
      final place = placeBySlug(answer.placeSlug ?? '');
      if (place == null) {
        return l10n.guideUnknown;
      }
      return l10n.guideStopReply(place.nameFor(languageCode));
    default:
      return l10n.guideUnknown;
  }
}

/// Place to open on the map, when the question names one place.
String? placeSlugForQuestion(String question) {
  final asked = question.toLowerCase();
  const places = <String, String>{
    'entrance': 'entrance',
    'መግቢያ': 'entrance',
    '5gna': '5gna-ber',
    '5ኛ': '5gna-ber',
    '6gna': '6gna-ber',
    '6ኛ': '6gna-ber',
    'coffee': 'coffee',
    'ቡና': 'coffee',
    'restaurant': 'restaurant',
    'ምግብ': 'restaurant',
    'parking': 'parking',
    'ማቆሚያ': 'parking',
    'restroom': 'restrooms',
    'toilet': 'restrooms',
    'መጸዳጃ': 'restrooms',
    'exit': 'exits',
    'መውጫ': 'exits',
  };

  if (asked.contains('hall') || asked.contains('ቤር')) {
    return null;
  }
  for (final place in places.entries) {
    if (asked.contains(place.key)) {
      return place.value;
    }
  }
  return null;
}
