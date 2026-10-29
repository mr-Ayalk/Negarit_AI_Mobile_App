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
  return l10n.guideReply;
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
