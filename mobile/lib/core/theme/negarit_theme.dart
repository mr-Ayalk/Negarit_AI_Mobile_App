import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_radius.dart';

abstract final class NegaritTheme {
  static ThemeData light() {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: NegaritColors.primary,
      onPrimary: Colors.white,
      secondary: NegaritColors.primaryDark,
      onSecondary: Colors.white,
      error: NegaritColors.error,
      onError: Colors.white,
      surface: NegaritColors.surface,
      onSurface: NegaritColors.text,
      surfaceTint: Colors.transparent,
    );

    final textTheme = Typography.material2021().black.apply(
      fontFamily: 'PlusJakartaSans',
      fontFamilyFallback: const ['NotoSansEthiopic', 'NotoNaskhArabic'],
      bodyColor: NegaritColors.text,
      displayColor: NegaritColors.text,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: NegaritColors.skyTop,
      textTheme: textTheme,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: NegaritColors.surface,
        elevation: 12,
        shadowColor: NegaritColors.primary.withValues(alpha: 0.08),
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected
                ? NegaritColors.primary
                : NegaritColors.textSecondary,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: selected
                ? NegaritColors.primary
                : NegaritColors.textSecondary,
          );
        }),
      ),
      cardTheme: CardThemeData(
        color: NegaritColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NegaritRadius.card),
        ),
      ),
    );
  }
}
