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

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundDark),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.kineticGreen,
      onPrimary: AppColors.backgroundDark,
      secondary: AppColors.pulseBlue,
      onSecondary: AppColors.backgroundDark,
      surface: AppColors.surfaceGreen,
      onSurface: AppColors.textHighDark,
      error: AppColors.danger,
      onError: AppColors.backgroundDark,
    ),
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
