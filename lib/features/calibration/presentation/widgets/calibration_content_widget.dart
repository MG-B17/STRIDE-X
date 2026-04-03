import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/app_button.dart';

class CalibrationContentWidget extends StatelessWidget {
  const CalibrationContentWidget({super.key,required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 90.w,
          height: 90.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colorScheme.primary.withAlpha(128),
              width: 4,
            ),
          ),
          alignment: Alignment.center,
          child: Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colorScheme.secondary, width: 4),
            ),
            child: Icon(
              Icons.directions_walk,
              color: context.colorScheme.primary,
              size: 32,
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          AppStrings.calibrateWithWalk,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurface,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          AppStrings.calibrateWalkDesc,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            height: 1.5,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 24.h),
        AppButton(onNext: onNext, text: AppStrings.startCalibrationWalk),
      ],
    );
  }
}
