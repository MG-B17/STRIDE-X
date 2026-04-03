import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:stridex/core/utils/extentions.dart';

class CalibrationProgressWidget extends StatelessWidget {
  final int steps;
  const CalibrationProgressWidget({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 200.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 180.w,
                height: 180.w,
                child: CircularProgressIndicator(
                  value: (steps / 10).clamp(0.0, 1.0),
                  strokeWidth: 8.w,
                  backgroundColor: context.colorScheme.primaryContainer,
                  color: context.colorScheme.primary,
                ),
              ),
              LottieBuilder.asset("assets/lottie/Teen Walking.json"),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "$steps / 10 steps detected",
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Make sure to walk around for a few seconds to allow the app to detect your steps accurately.",
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
