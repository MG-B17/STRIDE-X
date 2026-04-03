import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';

class CalibrationSuccessWidget extends StatelessWidget {
  const CalibrationSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle,
          color: context.colorScheme.primary,
          size: 60.sp,
        ),
        SizedBox(height: 16.h),
        Text(
          AppStrings.calibrationSuccess,
          style: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
