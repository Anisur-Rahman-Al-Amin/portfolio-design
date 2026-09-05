import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

abstract final class AppTheme {
  static ThemeData light() => _theme(Brightness.light);
  static ThemeData dark() => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: dark ? const Color(0xFF818CF8) : AppColors.primary,
        secondary: dark ? const Color(0xFF38BDF8) : AppColors.secondary,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: dark ? AppColors.darkBackground : AppColors.lightBackground,
      fontFamily: 'Segoe UI',
      cardTheme: CardThemeData(
        elevation: 0,
        color: dark ? AppColors.darkSurface : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: dark ? Colors.white10 : AppColors.lightBorder),
        ),
      ),
    );
  }
}
