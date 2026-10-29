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
    );

    final textTheme = Typography.material2021().black.apply(
      fontFamily: 'PlusJakartaSans',
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
        indicatorColor: NegaritColors.primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
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
