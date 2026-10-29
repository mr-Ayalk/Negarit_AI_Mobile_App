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
}
