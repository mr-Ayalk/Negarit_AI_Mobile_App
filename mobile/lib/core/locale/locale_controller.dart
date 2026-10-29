import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const visitLanguageKey = 'visit-language';

const visitLanguages = <({String code, String label})>[
  (code: 'en', label: 'English'),
  (code: 'am', label: 'አማርኛ'),
  (code: 'ar', label: 'العربية'),
];

class LocaleController extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final code = preferences.getString(visitLanguageKey);
      if (visitLanguages.any((language) => language.code == code)) {
        return code;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  Future<void> select(String languageCode) async {
    state = AsyncData(languageCode);
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(visitLanguageKey, languageCode);
    } catch (_) {
      return;
    }
  }
}

final localeProvider = AsyncNotifierProvider<LocaleController, String?>(
  LocaleController.new,
);
