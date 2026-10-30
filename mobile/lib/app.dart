import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/core/routing/app_router.dart';
import 'package:negarit_mobile/core/theme/negarit_theme.dart';
import 'package:negarit_mobile/features/flow/flow_state.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class NegaritApp extends ConsumerWidget {
  const NegaritApp({super.key, this.locale});

  /// Forces a locale in tests. The visitor's saved language is used otherwise.
  final Locale? locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final saved = ref.watch(chosenLanguageProvider).value?.code ?? 'en';
    final materialCode = saved == 'am' || saved == 'ar' ? saved : 'en';
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      locale: locale ?? Locale(materialCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: NegaritTheme.light(),
      routerConfig: router,
      builder: (context, child) {
        return Directionality(
          textDirection: saved == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
