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
  String get exploreEmptyBody =>
      'Guided tours appear here after a venue pack is installed. Adwa Museum content is not on this device yet.';

  @override
  String get mapEmptyTitle => 'Map is waiting for a venue';

  @override
  String get mapEmptyBody =>
      'Coffee, parking, restrooms, and exhibits will show on the venue map after a pack is installed.';

  @override
  String get favoritesEmptyTitle => 'No saved places';

  @override
  String get favoritesEmptyBody =>
      'Places you save during a visit will show up here.';

  @override
  String get profileEmptyTitle => 'Profile is not set up';

  @override
  String get profileEmptyBody =>
      'Language, privacy controls, and offline packs will be available here.';

  @override
  String get exploreHello => 'Hi there,';

  @override
  String get explorePromptLead => 'How can I ';

  @override
  String get explorePromptEmphasis => 'guide you';

  @override
  String get explorePromptEnd => '?';

  @override
  String get exploreSubtitle => 'What would you like to see?';

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
  String get suggestedStories => 'Stories';

  @override
  String get suggestedAudio => 'Audio';

  @override
  String get notLoaded => 'Not loaded';

  @override
  String get tourTitle => 'Adwa Museum';

  @override
  String get tourBody => 'Stories, audio, and stops are not loaded yet.';

  @override
  String get playAudio => 'Play audio';

  @override
  String get audioUnavailable => 'Audio is not on this device yet.';

  @override
  String get openMap => 'Map';

  @override
  String get guideTitle => 'Ask Negarit';

  @override
  String get guideNotice =>
      'The guide is not connected. Messages here are not museum answers.';

  @override
  String get guideHint => 'Type a message';

  @override
  String get guideSend => 'Send';

  @override
  String get guideReply =>
      'I can\'t answer from museum sources yet. The guide is not connected.';

  @override
  String get mapPreview => 'Floor plan preview';

  @override
  String get mapWaiting => 'Zones are not loaded.';

  @override
  String get guestLabel => 'Guest';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profilePrivacy => 'Privacy';

  @override
  String get profileOffline => 'Offline pack';

  @override
  String get notSetUp => 'Not set up';

  @override
  String get stopsHeading => 'Placeholder stops';

  @override
  String get stopsBody =>
      'These are the planned Adwa areas. Stories are not loaded.';
}
