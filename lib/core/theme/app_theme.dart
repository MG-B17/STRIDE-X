import 'package:flutter/material.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/theme/text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.backgroundLight),
    colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.kineticGreen,
        onPrimary: AppColors.backgroundLight,
        primaryContainer: AppColors.kineticGreen.withValues(alpha: 0.1),
        secondary: AppColors.pulseBlue,
        onSecondary: AppColors.backgroundLight,
        surface: AppColors.softSlate,
        onSurface: AppColors.textHighLight,
        error: AppColors.danger,
        onError: AppColors.backgroundLight,
        surfaceContainer: AppColors.backgroundLight,
        secondaryContainer: AppColors.kineticGreen.withValues(alpha: 0.15),
        onSecondaryContainer: AppColors.kineticGreen.withValues(alpha: 0.05),
        outline: AppColors.borderStrokeLight,
        outlineVariant: AppColors.borderStrokeLight),
    textTheme: TextTheme(
      displayLarge: AppTextStylesLight.display,
      headlineLarge: AppTextStylesLight.headline1,
      headlineMedium: AppTextStylesLight.headline2,
      headlineSmall: AppTextStylesLight.headline3,
      bodyLarge: AppTextStylesLight.bodyLarge,
      bodyMedium: AppTextStylesLight.body,
      bodySmall: AppTextStylesLight.caption,
      labelLarge: AppTextStylesLight.button,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundDark),
    colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.kineticGreen,
        onPrimary: AppColors.backgroundDark,
        primaryContainer: AppColors.surfaceGreen.withValues(alpha: 0.5),
        secondary: AppColors.pulseBlue,
        onSecondary: AppColors.backgroundDark,
        surface: AppColors.surfaceGreen,
        onSurface: AppColors.textHighDark,
        secondaryContainer: const Color(0xFF1A4D2E),
        onSecondaryContainer: const Color(0xFF0D2918),
        error: AppColors.danger,
        onError: AppColors.backgroundDark,
        outline: AppColors.borderStrokeDark,
        outlineVariant: AppColors.borderStrokeDark),
    textTheme: TextTheme(
      displayLarge: AppTextStylesDark.display,
      headlineLarge: AppTextStylesDark.headline1,
      headlineMedium: AppTextStylesDark.headline2,
      headlineSmall: AppTextStylesDark.headline3,
      bodyLarge: AppTextStylesDark.bodyLarge,
      bodyMedium: AppTextStylesDark.body,
      bodySmall: AppTextStylesDark.caption,
      labelLarge: AppTextStylesDark.button,
    ),
  );

  static ThemeData lightColor = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundLight),
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.kineticGreen,
      onPrimary: AppColors.backgroundLight,
      secondary: AppColors.pulseBlue,
      onSecondary: AppColors.backgroundLight,
      surface: AppColors.softSlate,
      onSurface: AppColors.textHighLight,
      error: AppColors.danger,
      onError: AppColors.backgroundLight,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStylesLight.display,
      headlineLarge: AppTextStylesLight.headline1,
      headlineMedium: AppTextStylesLight.headline2,
      headlineSmall: AppTextStylesLight.headline3,
      bodyLarge: AppTextStylesLight.bodyLarge,
      bodyMedium: AppTextStylesLight.body,
      bodySmall: AppTextStylesLight.caption,
      labelLarge: AppTextStylesLight.button,
    ),
  );
}
