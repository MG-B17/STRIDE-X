import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';

class CompleteCalibrationButton extends StatelessWidget {
  const CompleteCalibrationButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          spacing: 8.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.completeCalibration,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSecondary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: context.colorScheme.onSecondary,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
