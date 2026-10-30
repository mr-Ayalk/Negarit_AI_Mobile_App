// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'نيغاريت AI';

  @override
  String get navExplore => 'استكشف';

  @override
  String get navMap => 'الخريطة';

  @override
  String get navFavorites => 'المفضلة';

  @override
  String get navProfile => 'الملف';

  @override
  String get exploreGreeting => 'أهلاً بك في نيغاريت';

  @override
  String get exploreEmptyTitle => 'لم يُحمَّل موقع';

  @override
  String get exploreEmptyBody =>
      'تظهر الجولات الإرشادية هنا بعد تثبيت حزمة الموقع. محتوى متحف عدوا غير موجود على هذا الجهاز بعد.';

  @override
  String get mapEmptyTitle => 'الخريطة بانتظار موقع';

  @override
  String get mapEmptyBody =>
      'ستظهر القهوة ومواقف السيارات ودورات المياه والمعارض على خريطة الموقع بعد تثبيت الحزمة.';

  @override
  String get favoritesEmptyTitle => 'لا أماكن محفوظة';

  @override
  String get favoritesEmptyBody =>
      'ستظهر هنا الأماكن التي تحفظها أثناء الزيارة.';

  @override
  String get profileEmptyTitle => 'الملف غير مُعد';

  @override
  String get profileEmptyBody => 'أنت تزور متحف عدوا.';

  @override
  String get exploreHello => 'أهلاً بك،';

  @override
  String get explorePromptLead => 'هذه زيارة ';

  @override
  String get explorePromptEmphasis => 'متحف عدوا';

  @override
  String get explorePromptEnd => '';

  @override
  String get exploreSubtitle =>
      'امشِ في الزيارة، أو ابحث عن مكان، أو اسأل عن المسار.';

  @override
  String get chipAsk => 'اسأل سؤالاً';

  @override
  String get chipTour => 'ابدأ الجولة';

  @override
  String get chipZone => 'اعثر على منطقة';

  @override
  String get chipSaved => 'الأماكن المحفوظة';

  @override
  String get suggestedTitle => 'مقترح لك';

  @override
  String get suggestedStories => 'ثمانية أماكن';

  @override
  String get suggestedAudio => 'خريطة الزيارة';

  @override
  String get visitCountBody => 'من المدخل إلى المخارج';

  @override
  String get visitMapBody => 'القاعات والقهوة والمرافق';

  @override
  String get notLoaded => 'غير محمّل';

  @override
  String get tourTitle => 'متحف عدوا';

  @override
  String get tourBody => 'ابدأ من المدخل، ثم القاعة الخامسة والقاعة السادسة.';

  @override
  String get playAudio => 'تشغيل الصوت';

  @override
  String get audioUnavailable => 'الصوت غير موجود على هذا الجهاز بعد.';

  @override
  String get openMap => 'الخريطة';

  @override
  String get guideTitle => 'اسأل نيغاريت';

  @override
  String get guideNotice => 'اسأل عن أماكن هذه الزيارة.';

  @override
  String get guideHint => 'اكتب رسالة';

  @override
  String get guideSend => 'إرسال';

  @override
  String get guideReply =>
      'تبدأ الزيارة من المدخل، ثم القاعة الخامسة والسادسة، ثم القهوة والمطعم ومواقف السيارات ودورات المياه والمخارج.';

  @override
  String get guideHallsReply =>
      'القاعات في هذه الزيارة هي القاعة الخامسة والقاعة السادسة.';

  @override
  String guideStopReply(String name) {
    return '$name ضمن زيارة متحف عدوا.';
  }

  @override
  String get mapPreview => 'متحف عدوا';

  @override
  String get mapAround => 'حول المتحف';

  @override
  String get mapInside => 'داخل الزيارة';

  @override
  String get mapAroundBody => 'متحف عدوا 00 كم، بياسا، أديس أبابا.';

  @override
  String get mapWaiting =>
      'المدخل والقاعات والقهوة والمطعم ومواقف السيارات ودورات المياه والمخارج.';

  @override
  String get guestLabel => 'زائر';

  @override
  String get chooseLanguage => 'اختر لغة';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get signInBody =>
      'استخدم هاتفاً أو بريداً. يُطبع الرمز في سجل واجهة البرمجة، ولا يُرسل برسالة.';

  @override
  String get signInHint => 'الهاتف أو البريد';

  @override
  String get signInSend => 'إرسال الرمز';

  @override
  String get signInCodeHint => 'الرمز من سجل واجهة البرمجة';

  @override
  String get signInConfirm => 'تأكيد الرمز';

  @override
  String get signInWaiting => 'طُبع الرمز في سجل واجهة البرمجة.';

  @override
  String get signInInvalid => 'هذا الرمز غير صالح.';

  @override
  String get signInUnreachable =>
      'لا يستطيع هذا الهاتف الوصول إلى الواجهة. أبقه متصلاً بالحاسوب ثم أعد المحاولة.';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get profileLanguageValue => 'هذا الهاتف';

  @override
  String get profilePrivacy => 'الخصوصية';

  @override
  String get profilePrivacyValue => 'على هذا الهاتف';

  @override
  String get profileVisit => 'الزيارة';

  @override
  String get profileVisitValue => 'متحف عدوا';

  @override
  String get profileOffline => 'حزمة دون اتصال';

  @override
  String get notSetUp => 'غير مُعد';

  @override
  String get stopsHeading => 'الأماكن';

  @override
  String get stopsBody => 'هذه الأماكن ضمن زيارة متحف عدوا.';

  @override
  String get placeSave => 'حفظ المكان';

  @override
  String get placeSaved => 'محفوظ';

  @override
  String get placeStoryMissing => 'لا توجد قصة مراجعة لهذا المكان.';

  @override
  String get placeTypeEntrance => 'المدخل';

  @override
  String get placeTypeHall => 'قاعة';

  @override
  String get placeTypeFacility => 'مرفق';

  @override
  String get placeMissing => 'هذا المكان ليس ضمن الزيارة.';

  @override
  String get interestsTitle => 'الاهتمامات';

  @override
  String get interestsNone => 'لم يُختر شيء';

  @override
  String get interestsDone => 'تم';

  @override
  String get interestHalls => 'القاعات';

  @override
  String get interestCoffee => 'القهوة';

  @override
  String get interestFood => 'الطعام';

  @override
  String get interestParking => 'المواقف';

  @override
  String get interestRestrooms => 'دورات المياه';

  @override
  String get profileSaved => 'الأماكن المحفوظة';

  @override
  String get profileSignOut => 'تسجيل الخروج';

  @override
  String get profileAccountBody =>
      'تبقى اللغة والاهتمامات والأماكن المحفوظة على هذا الهاتف.';

  @override
  String get profilePrivacyBody =>
      'لا يُحفظ رمز الدخول. لا يُرسل شيء إلى ملف سحابي بعد.';

  @override
  String get suggestedInterests => 'حسب اهتماماتك';

  @override
  String get favoritesRemove => 'إزالة';

  @override
  String get beaconHere => 'أنا هنا';

  @override
  String get beaconSimulated => 'محاكاة. هذا الهاتف لا يمسح البلوتوث.';

  @override
  String get beaconChoose => 'اختر المكان الذي تقف فيه.';

  @override
  String beaconWelcome(String name) {
    return 'مرحباً $name، أهلاً بك في متحف عدوا.';
  }

  @override
  String beaconAt(String name) {
    return 'أنت عند $name.';
  }

  @override
  String get beaconCooldown => 'تم الإعلان عن هذا المكان مسبقاً.';

  @override
  String facilityOnVisit(String name) {
    return '$name ضمن هذه الزيارة.';
  }

  @override
  String get facilitySchematic => 'هذا الرسم ليس مساراً مقيساً.';

  @override
  String get facilityOpen => 'افتح المكان';

  @override
  String get guideUnknown =>
      'هذا ليس في قائمة الزيارة. لم يُحمَّل مصدر متحف مراجع.';

  @override
  String get guideSource => 'من قائمة الزيارة. ليس مصدر متحف مراجعاً.';

  @override
  String get guideLocal => 'أُجيب على هذا الهاتف لأن خدمة الدليل لم تُبلغ.';

  @override
  String get placeCodeHelp =>
      'اكتب النص الذي يحمله رمز QR المطبوع. الكاميرا لا تمسح.';

  @override
  String get placeCodeHint => 'coffee';

  @override
  String get placeCodeUse => 'استخدم هذا الرمز';

  @override
  String get placeCodeUnknown => 'هذا الرمز ليس مكاناً في هذه الزيارة.';
}
