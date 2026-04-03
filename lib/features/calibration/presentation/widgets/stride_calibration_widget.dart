import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';

class StrideCalibrationWidget extends StatelessWidget {
  const StrideCalibrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppStrings.strideCalibration, style: context.textTheme.displaySmall?.copyWith(color: context.colorScheme.onSurface,fontSize: 24.sp,fontWeight: FontWeight.w600,),),
        Icon(Icons.help_outline, color: context.colorScheme.primary, size: 20),
      ],
    );
  }
}
