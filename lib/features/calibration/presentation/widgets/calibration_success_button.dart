import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/theme/app_color.dart';

class CalibrationSuccessButton extends StatefulWidget {
  const CalibrationSuccessButton({super.key});

  @override
  State<CalibrationSuccessButton> createState() => _CalibrationSuccessButtonState();
}

class _CalibrationSuccessButtonState extends State<CalibrationSuccessButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.goNamed(AppRouteConstant.homeScreenRoute);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          AppStrings.proceedToHomeScreen,
          style: TextStyle(
            color: AppColors.backgroundDark,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}



