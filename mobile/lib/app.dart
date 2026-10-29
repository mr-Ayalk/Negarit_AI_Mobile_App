import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/core/routing/app_router.dart';
import 'package:negarit_mobile/core/theme/negarit_theme.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class NegaritApp extends ConsumerWidget {
  const NegaritApp({super.key, this.locale});

  /// Overrides the device locale. Tests use this to check Arabic layout.
  final Locale? locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: NegaritTheme.light(),
      routerConfig: router,
    );
  }
}
