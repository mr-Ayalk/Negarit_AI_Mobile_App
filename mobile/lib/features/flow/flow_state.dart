import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/core/locale/locale_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChosenLanguage {
  const ChosenLanguage(this.code, this.label);

  final String code;
  final String label;
}

const visitLanguageChoices = <ChosenLanguage>[
  ChosenLanguage('en', 'English'),
  ChosenLanguage('am', 'አማርኛ'),
  ChosenLanguage('ar', 'العربية'),
  ChosenLanguage('fr', 'Français'),
  ChosenLanguage('om', 'Afaan Oromoo'),
  ChosenLanguage('ti', 'ትግርኛ'),
  ChosenLanguage('so', 'Soomaali'),
];

ChosenLanguage languageByCode(String? code) {
  for (final language in visitLanguageChoices) {
    if (language.code == code) {
      return language;
    }
  }
  return visitLanguageChoices.first;
}

class ChosenLanguageController extends AsyncNotifier<ChosenLanguage> {
  @override
  Future<ChosenLanguage> build() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      return languageByCode(preferences.getString(visitLanguageKey));
    } catch (_) {
      return visitLanguageChoices.first;
    }
  }

  Future<void> choose(ChosenLanguage language) async {
    state = AsyncData(language);
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(visitLanguageKey, language.code);
    } catch (_) {
      return;
    }
  }
}

final chosenLanguageProvider =
    AsyncNotifierProvider<ChosenLanguageController, ChosenLanguage>(
      ChosenLanguageController.new,
    );
