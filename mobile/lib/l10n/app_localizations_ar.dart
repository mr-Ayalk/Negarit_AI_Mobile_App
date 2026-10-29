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
  String get profileEmptyBody =>
      'ستتوفر هنا اللغة وضوابط الخصوصية وحزم الاستخدام دون اتصال.';

  @override
  String get exploreHello => 'أهلاً،';

  @override
  String get explorePromptLead => 'كيف يمكنني ';

  @override
  String get explorePromptEmphasis => 'إرشادك';

  @override
  String get explorePromptEnd => '؟';

  @override
  String get exploreSubtitle => 'ماذا تود أن ترى؟';

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
  String get suggestedStories => 'قصص';

  @override
  String get suggestedAudio => 'صوت';

  @override
  String get notLoaded => 'غير محمّل';

  @override
  String get tourTitle => 'متحف عدوا';

  @override
  String get tourBody => 'القصص والصوت والمحطات غير محمّلة بعد.';

  @override
  String get playAudio => 'تشغيل الصوت';

  @override
  String get audioUnavailable => 'الصوت غير موجود على هذا الجهاز بعد.';

  @override
  String get openMap => 'الخريطة';

  @override
  String get guideTitle => 'اسأل نيغاريت';

  @override
  String get guideNotice => 'الدليل غير متصل. الرسائل هنا ليست إجابات المتحف.';

  @override
  String get guideHint => 'اكتب رسالة';

  @override
  String get guideSend => 'إرسال';

  @override
  String get guideReply =>
      'لا أستطيع الإجابة من مصادر المتحف بعد. الدليل غير متصل.';

  @override
  String get mapPreview => 'معاينة مخطط الطابق';

  @override
  String get mapWaiting => 'المناطق غير محمّلة.';

  @override
  String get guestLabel => 'زائر';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get profilePrivacy => 'الخصوصية';

  @override
  String get profileOffline => 'حزمة دون اتصال';

  @override
  String get notSetUp => 'غير مُعد';

  @override
  String get stopsHeading => 'محطات مخططة';

  @override
  String get stopsBody => 'هذه مناطق عدوا المخططة. القصص غير محمّلة.';
}
