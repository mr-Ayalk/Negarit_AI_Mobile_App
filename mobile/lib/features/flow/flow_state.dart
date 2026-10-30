import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChosenLanguage {
  const ChosenLanguage(this.code, this.label);

  final String code;
  final String label;
}

class ChosenLanguageController extends Notifier<ChosenLanguage> {
  @override
  ChosenLanguage build() => const ChosenLanguage('en', 'English');

  void choose(ChosenLanguage language) {
    state = language;
  }
}

final chosenLanguageProvider =
    NotifierProvider<ChosenLanguageController, ChosenLanguage>(
      ChosenLanguageController.new,
    );

const visitorName = 'Abebe';
const visitorFullName = 'Abebe Kebede';
const visitorPhone = '+251 9 12 345 678';
