import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';

const String fontFamily = 'Manrope';

class AppTextStylesDark {

  static TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48.sp,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.02,
    color: AppColors.textHighDark,
  );

  static TextStyle headline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.01,
    color: AppColors.textHighDark,
  );

  static TextStyle headline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.01,
    color: AppColors.textHighDark,
  );

  static TextStyle headline3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0,
    color: AppColors.textHighDark,
  );

  static TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 0,
    color: AppColors.textMediumDark,
  );

  static TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 0,
    color: AppColors.textMediumDark,
  );

  static TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.05,
    color: AppColors.textLowDark,
  );

  static TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0.02,
    color: AppColors.kineticGreen,
  );
}

class AppTextStylesLight {

  static TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48.sp,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.02,
    color: AppColors.textHighLight,
  );

  static TextStyle headline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.01,
    color: AppColors.textHighLight,
  );

  static TextStyle headline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.01,
    color: AppColors.textHighLight,
  );

  static TextStyle headline3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0,
    color: AppColors.textHighLight,
  );

  static TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 0,
    color: AppColors.textMediumLight,
  );

  static TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 0,
    color: AppColors.textMediumLight,
  );

  static TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.05,
    color: AppColors.textLowLight,
  );

  static TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0.02,
    color: AppColors.kineticGreen,
  );
}