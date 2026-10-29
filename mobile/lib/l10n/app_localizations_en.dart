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
}
