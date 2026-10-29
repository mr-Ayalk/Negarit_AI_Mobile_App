import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('ar'),
    Locale('en'),
  ];

  /// Application name shown in the title bar.
  ///
  /// In en, this message translates to:
  /// **'Negarit AI'**
  String get appTitle;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navMap;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @exploreGreeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Negarit'**
  String get exploreGreeting;

  /// No description provided for @exploreEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No venue loaded'**
  String get exploreEmptyTitle;

  /// No description provided for @exploreEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Guided tours appear here after a venue pack is installed. Adwa Museum content is not on this device yet.'**
  String get exploreEmptyBody;

  /// No description provided for @mapEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Map is waiting for a venue'**
  String get mapEmptyTitle;

  /// No description provided for @mapEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Coffee, parking, restrooms, and exhibits will show on the venue map after a pack is installed.'**
  String get mapEmptyBody;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No saved places'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Places you save during a visit will show up here.'**
  String get favoritesEmptyBody;

  /// No description provided for @profileEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile is not set up'**
  String get profileEmptyTitle;

  /// No description provided for @profileEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'You are visiting Adwa Museum.'**
  String get profileEmptyBody;

  /// No description provided for @exploreHello.
  ///
  /// In en, this message translates to:
  /// **'Welcome,'**
  String get exploreHello;

  /// No description provided for @explorePromptLead.
  ///
  /// In en, this message translates to:
  /// **'This is '**
  String get explorePromptLead;

  /// No description provided for @explorePromptEmphasis.
  ///
  /// In en, this message translates to:
  /// **'Adwa Museum'**
  String get explorePromptEmphasis;

  /// No description provided for @explorePromptEnd.
  ///
  /// In en, this message translates to:
  /// **''**
  String get explorePromptEnd;

  /// No description provided for @exploreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Walk the visit, find a place, or ask about the route.'**
  String get exploreSubtitle;

  /// No description provided for @chipAsk.
  ///
  /// In en, this message translates to:
  /// **'Ask a question'**
  String get chipAsk;

  /// No description provided for @chipTour.
  ///
  /// In en, this message translates to:
  /// **'Start a tour'**
  String get chipTour;

  /// No description provided for @chipZone.
  ///
  /// In en, this message translates to:
  /// **'Find a zone'**
  String get chipZone;

  /// No description provided for @chipSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved places'**
  String get chipSaved;

  /// No description provided for @suggestedTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggested for you'**
  String get suggestedTitle;

  /// No description provided for @suggestedStories.
  ///
  /// In en, this message translates to:
  /// **'Eight places'**
  String get suggestedStories;

  /// No description provided for @suggestedAudio.
  ///
  /// In en, this message translates to:
  /// **'Visit map'**
  String get suggestedAudio;

  /// No description provided for @visitCountBody.
  ///
  /// In en, this message translates to:
  /// **'Entrance through the exits'**
  String get visitCountBody;

  /// No description provided for @visitMapBody.
  ///
  /// In en, this message translates to:
  /// **'Halls, coffee, and facilities'**
  String get visitMapBody;

  /// No description provided for @notLoaded.
  ///
  /// In en, this message translates to:
  /// **'Not loaded'**
  String get notLoaded;

  /// No description provided for @tourTitle.
  ///
  /// In en, this message translates to:
  /// **'Adwa Museum'**
  String get tourTitle;

  /// No description provided for @tourBody.
  ///
  /// In en, this message translates to:
  /// **'Start at the entrance, then 5gna Ber and 6gna Ber.'**
  String get tourBody;

  /// No description provided for @playAudio.
  ///
  /// In en, this message translates to:
  /// **'Play audio'**
  String get playAudio;

  /// No description provided for @audioUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Audio is not on this device yet.'**
  String get audioUnavailable;

  /// No description provided for @openMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get openMap;

  /// No description provided for @guideTitle.
  ///
  /// In en, this message translates to:
  /// **'Ask Negarit'**
  String get guideTitle;

  /// No description provided for @guideNotice.
  ///
  /// In en, this message translates to:
  /// **'Ask about the places on this visit.'**
  String get guideNotice;

  /// No description provided for @guideHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get guideHint;

  /// No description provided for @guideSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get guideSend;

  /// No description provided for @guideReply.
  ///
  /// In en, this message translates to:
  /// **'The visit starts at the entrance, then 5gna Ber and 6gna Ber, then coffee, the restaurant, parking, restrooms, and the exits.'**
  String get guideReply;

  /// No description provided for @guideHallsReply.
  ///
  /// In en, this message translates to:
  /// **'The halls on this visit are 5gna Ber and 6gna Ber.'**
  String get guideHallsReply;

  /// No description provided for @guideStopReply.
  ///
  /// In en, this message translates to:
  /// **'{name} is on the Adwa Museum visit.'**
  String guideStopReply(String name);

  /// No description provided for @mapPreview.
  ///
  /// In en, this message translates to:
  /// **'Adwa Museum'**
  String get mapPreview;

  /// No description provided for @mapAround.
  ///
  /// In en, this message translates to:
  /// **'Around the museum'**
  String get mapAround;

  /// No description provided for @mapInside.
  ///
  /// In en, this message translates to:
  /// **'Inside the visit'**
  String get mapInside;

  /// No description provided for @mapAroundBody.
  ///
  /// In en, this message translates to:
  /// **'Adwa 00KM Museum, Piassa, Addis Ababa.'**
  String get mapAroundBody;

  /// No description provided for @mapWaiting.
  ///
  /// In en, this message translates to:
  /// **'Entrance, halls, coffee, restaurant, parking, restrooms, and exits.'**
  String get mapWaiting;

  /// No description provided for @guestLabel.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guestLabel;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose a language'**
  String get chooseLanguage;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signInBody.
  ///
  /// In en, this message translates to:
  /// **'Use a phone number or email. The code is printed in the API log, not sent by SMS.'**
  String get signInBody;

  /// No description provided for @signInHint.
  ///
  /// In en, this message translates to:
  /// **'Phone or email'**
  String get signInHint;

  /// No description provided for @signInSend.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get signInSend;

  /// No description provided for @signInCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Code from the API log'**
  String get signInCodeHint;

  /// No description provided for @signInConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm code'**
  String get signInConfirm;

  /// No description provided for @signInWaiting.
  ///
  /// In en, this message translates to:
  /// **'The code is printed in the API log.'**
  String get signInWaiting;

  /// No description provided for @signInInvalid.
  ///
  /// In en, this message translates to:
  /// **'That code is not valid.'**
  String get signInInvalid;

  /// No description provided for @signInUnreachable.
  ///
  /// In en, this message translates to:
  /// **'This phone cannot reach the API. Keep it connected to the computer and try again.'**
  String get signInUnreachable;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileLanguageValue.
  ///
  /// In en, this message translates to:
  /// **'This phone'**
  String get profileLanguageValue;

  /// No description provided for @profilePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get profilePrivacy;

  /// No description provided for @profilePrivacyValue.
  ///
  /// In en, this message translates to:
  /// **'On this phone'**
  String get profilePrivacyValue;

  /// No description provided for @profileVisit.
  ///
  /// In en, this message translates to:
  /// **'Visit'**
  String get profileVisit;

  /// No description provided for @profileVisitValue.
  ///
  /// In en, this message translates to:
  /// **'Adwa Museum'**
  String get profileVisitValue;

  /// No description provided for @profileOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline pack'**
  String get profileOffline;

  /// No description provided for @notSetUp.
  ///
  /// In en, this message translates to:
  /// **'Not set up'**
  String get notSetUp;

  /// No description provided for @stopsHeading.
  ///
  /// In en, this message translates to:
  /// **'Places'**
  String get stopsHeading;

  /// No description provided for @stopsBody.
  ///
  /// In en, this message translates to:
  /// **'These places are on the Adwa Museum visit.'**
  String get stopsBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
