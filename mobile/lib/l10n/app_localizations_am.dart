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
  String get profileEmptyBody => 'የአድዋ ሙዚየም እየጎበኙ ነው።';

  @override
  String get exploreHello => 'እንኳን ደህና መጡ፣';

  @override
  String get explorePromptLead => 'ይህ ';

  @override
  String get explorePromptEmphasis => 'የአድዋ ሙዚየም';

  @override
  String get explorePromptEnd => ' ነው';

  @override
  String get exploreSubtitle => 'ጉብኝቱን ይራመዱ፣ ቦታ ያግኙ፣ ወይም ስለ መንገዱ ይጠይቁ።';

  @override
  String get chipAsk => 'ጥያቄ ይጠይቁ';

  @override
  String get chipTour => 'ጉብኝት ይጀምሩ';

  @override
  String get chipZone => 'ቦታ ያግኙ';

  @override
  String get chipSaved => 'የተቀመጡ ቦታዎች';

  @override
  String get suggestedTitle => 'ለእርስዎ የተጠቆመ';

  @override
  String get suggestedStories => 'ስምንት ቦታዎች';

  @override
  String get suggestedAudio => 'የጉብኝት ካርታ';

  @override
  String get visitCountBody => 'ከመግቢያ እስከ መውጫ';

  @override
  String get visitMapBody => 'አዳራሾች፣ ቡና እና አገልግሎቶች';

  @override
  String get notLoaded => 'አልተጫነም';

  @override
  String get tourTitle => 'የአድዋ ሙዚየም';

  @override
  String get tourBody => 'ከመግቢያ ይጀምሩ፣ ከዚያ 5ኛ ቤር እና 6ኛ ቤር።';

  @override
  String get playAudio => 'ድምጽ ያጫውቱ';

  @override
  String get audioUnavailable => 'ድምጽ በዚህ መሣሪያ ላይ እስካሁን የለም።';

  @override
  String get openMap => 'ካርታ';

  @override
  String get guideTitle => 'ነጋሪትን ይጠይቁ';

  @override
  String get guideNotice => 'ስለ የጉብኝቱ ቦታዎች ይጠይቁ።';

  @override
  String get guideHint => 'መልዕክት ይጻፉ';

  @override
  String get guideSend => 'ላክ';

  @override
  String get guideReply =>
      'ጉብኝቱ ከመግቢያ ይጀምራል፣ ከዚያ 5ኛ ቤር እና 6ኛ ቤር፣ ቡና፣ ምግብ ቤት፣ ማቆሚያ፣ መጸዳጃ እና መውጫ።';

  @override
  String get guideHallsReply => 'በዚህ ጉብኝት ላይ ያሉ አዳራሾች 5ኛ ቤር እና 6ኛ ቤር ናቸው።';

  @override
  String guideStopReply(String name) {
    return '$name በየአድዋ ሙዚየም ጉብኝት ላይ ነው።';
  }

  @override
  String get mapPreview => 'የአድዋ ሙዚየም';

  @override
  String get mapAround => 'በሙዚየሙ ዙሪያ';

  @override
  String get mapInside => 'በጉብኝቱ ውስጥ';

  @override
  String get mapAroundBody => 'አድዋ 00 ኪ.ሜ ሙዚየም፣ ፒያሳ፣ አዲስ አበባ።';

  @override
  String get mapWaiting => 'መግቢያ፣ አዳራሾች፣ ቡና፣ ምግብ ቤት፣ ማቆሚያ፣ መጸዳጃ እና መውጫ።';

  @override
  String get guestLabel => 'እንግዳ';

  @override
  String get profileLanguage => 'ቋንቋ';

  @override
  String get profileLanguageValue => 'የዚህ ስልክ';

  @override
  String get profilePrivacy => 'ግላዊነት';

  @override
  String get profilePrivacyValue => 'በዚህ ስልክ ላይ';

  @override
  String get profileVisit => 'ጉብኝት';

  @override
  String get profileVisitValue => 'የአድዋ ሙዚየም';

  @override
  String get profileOffline => 'ከመስመር ውጭ ጥቅል';

  @override
  String get notSetUp => 'አልተዘጋጀም';

  @override
  String get stopsHeading => 'ቦታዎች';

  @override
  String get stopsBody => 'እነዚህ ቦታዎች በየአድዋ ሙዚየም ጉብኝት ላይ ናቸው።';
}
