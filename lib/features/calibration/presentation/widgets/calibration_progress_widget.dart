import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:stridex/core/utils/extentions.dart';

class CalibrationProgressWidget extends StatelessWidget {
  const CalibrationProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LottieBuilder.asset("assets/lottie/Teen Walking.json"),
        SizedBox(height: 16.h),
        Text(
          "Make sure to walk around for a few seconds to allow the app to detect your steps accurately.",
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurface,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
