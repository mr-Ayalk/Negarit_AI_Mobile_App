// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Negarit AI';

  @override
  String get navExplore => 'Explore';

  @override
  String get navMap => 'Map';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'Profile';

  @override
  String get exploreGreeting => 'Welcome to Negarit';

  @override
  String get exploreEmptyTitle => 'No venue loaded';

  @override
  String get exploreEmptyBody => 'Guided tours appear here after a venue pack is installed. Adwa Museum content is not on this device yet.';

  @override
  String get mapEmptyTitle => 'Map is waiting for a venue';

  @override
  String get mapEmptyBody => 'Coffee, parking, restrooms, and exhibits will show on the venue map after a pack is installed.';

  @override
  String get favoritesEmptyTitle => 'No saved places';

  @override
  String get favoritesEmptyBody => 'Places you save during a visit will show up here.';

  @override
  String get profileEmptyTitle => 'Profile is not set up';

  @override
  String get profileEmptyBody => 'You are visiting Adwa Museum.';

  @override
  String get exploreHello => 'Welcome,';

  @override
  String get explorePromptLead => 'This is ';

  @override
  String get explorePromptEmphasis => 'Adwa Museum';

  @override
  String get explorePromptEnd => '';

  @override
  String get exploreSubtitle => 'Walk the visit, find a place, or ask about the route.';

  @override
  String get chipAsk => 'Ask a question';

  @override
  String get chipTour => 'Start a tour';

  @override
  String get chipZone => 'Find a zone';

  @override
  String get chipSaved => 'Saved places';

  @override
  String get suggestedTitle => 'Suggested for you';

  @override
  String get suggestedStories => 'Eight places';

  @override
  String get suggestedAudio => 'Visit map';

  @override
  String get visitCountBody => 'Entrance through the exits';

  @override
  String get visitMapBody => 'Halls, coffee, and facilities';

  @override
  String get notLoaded => 'Not loaded';

  @override
  String get tourTitle => 'Adwa Museum';

  @override
  String get tourBody => 'Start at the entrance, then 5gna Ber and 6gna Ber.';

  @override
  String get playAudio => 'Play audio';

  @override
  String get audioUnavailable => 'Audio is not on this device yet.';

  @override
  String get openMap => 'Map';

  @override
  String get guideTitle => 'Ask Negarit';

  @override
  String get guideNotice => 'Ask about the places on this visit.';

  @override
  String get guideHint => 'Type a message';

  @override
  String get guideSend => 'Send';

  @override
  String get guideReply => 'The visit starts at the entrance, then 5gna Ber and 6gna Ber, then coffee, the restaurant, parking, restrooms, and the exits.';

  @override
  String get guideHallsReply => 'The halls on this visit are 5gna Ber and 6gna Ber.';

  @override
  String guideStopReply(String name) {
    return '$name is on the Adwa Museum visit.';
  }

  @override
  String get mapPreview => 'Adwa Museum';

  @override
  String get mapWaiting => 'Entrance, halls, coffee, restaurant, parking, restrooms, and exits.';

  @override
  String get guestLabel => 'Guest';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileLanguageValue => 'This phone';

  @override
  String get profilePrivacy => 'Privacy';

  @override
  String get profilePrivacyValue => 'On this phone';

  @override
  String get profileVisit => 'Visit';

  @override
  String get profileVisitValue => 'Adwa Museum';

  @override
  String get profileOffline => 'Offline pack';

  @override
  String get notSetUp => 'Not set up';

  @override
  String get stopsHeading => 'Places';

  @override
  String get stopsBody => 'These places are on the Adwa Museum visit.';
}
