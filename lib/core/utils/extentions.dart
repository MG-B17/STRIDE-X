import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ThemeExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ColorSchemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension AnalyticsLabelStyles on BuildContext {
  TextStyle get analyticsLabelStyle => TextStyle(
    fontFamily: 'Manrope',
    fontSize: 10.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.5,
    color: colorScheme.onSurface.withValues(alpha: 0.5),
  );
}

extension IntFormatting on int {
  String formatWithCommas() {
    final s = toString();
    return this >= 1000
        ? '${s.substring(0, s.length - 3)},${s.substring(s.length - 3)}'
        : s;
  }
}