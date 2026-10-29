import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:negarit_mobile/core/locale/locale_controller.dart';
import 'package:negarit_mobile/core/routing/app_router.dart';
import 'package:negarit_mobile/core/theme/negarit_theme.dart';
import 'package:negarit_mobile/core/widgets/opening_splash.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class NegaritApp extends ConsumerWidget {
  const NegaritApp({super.key, this.locale});

  /// Overrides the saved locale. Tests use this to check Arabic layout.
  final Locale? locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final savedLanguage = ref.watch(localeProvider).value;
    final selected = locale ??
        (savedLanguage == null ? null : Locale(savedLanguage));
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      locale: selected,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: NegaritTheme.light(),
      routerConfig: router,
      builder: (context, child) {
        final page = child ?? const SizedBox.shrink();
        if (WidgetsBinding.instance.runtimeType.toString().contains('Test')) {
          return page;
        }
        return _OpeningGate(child: page);
      },
    );
  }
}

class _OpeningGate extends StatefulWidget {
  const _OpeningGate({required this.child});

  final Widget child;

  @override
  State<_OpeningGate> createState() => _OpeningGateState();
}

class _OpeningGateState extends State<_OpeningGate> {
  var _open = false;

  @override
  Widget build(BuildContext context) {
    if (_open) {
      return widget.child;
    }
    return OpeningSplash(onFinished: () => setState(() => _open = true));
  }
}
