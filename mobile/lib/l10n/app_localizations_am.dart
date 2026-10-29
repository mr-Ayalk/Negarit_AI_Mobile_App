// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appTitle => 'ነጋሪት AI';

  @override
  String get navExplore => 'ያስሱ';

  @override
  String get navMap => 'ካርታ';

  @override
  String get navFavorites => 'ተወዳጆች';

  @override
  String get navProfile => 'መገለጫ';

  @override
  String get exploreGreeting => 'እንኳን ወደ ነጋሪት በደህና መጡ';

  @override
  String get exploreEmptyTitle => 'ቦታ አልተጫነም';

  @override
  String get exploreEmptyBody =>
      'የጉብኝት መመሪያ የቦታ ጥቅል ከተጫነ በኋላ እዚህ ይታያል። የአድዋ ሙዚየም ይዘት በዚህ መሣሪያ ላይ እስካሁን የለም።';

  @override
  String get mapEmptyTitle => 'ካርታው ቦታ እየጠበቀ ነው';

  @override
  String get mapEmptyBody =>
      'ቡና፣ ማቆሚያ፣ መጸዳጃ ቤት እና ኤግዚቢሽኖች የቦታ ጥቅል ከተጫነ በኋላ በካርታው ላይ ይታያሉ።';

  @override
  String get favoritesEmptyTitle => 'የተቀመጡ ቦታዎች የሉም';

  @override
  String get favoritesEmptyBody => 'በጉብኝት ወቅት የሚያስቀምጧቸው ቦታዎች እዚህ ይታያሉ።';

  @override
  String get profileEmptyTitle => 'መገለጫ አልተዘጋጀም';

  @override
  String get profileEmptyBody =>
      'ቋንቋ፣ የግላዊነት መቆጣጠሪያዎች እና ከመስመር ውጭ ጥቅሎች እዚህ ይገኛሉ።';
}
