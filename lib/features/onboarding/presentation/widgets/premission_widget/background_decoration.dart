import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/utils/extentions.dart';

class BackgroundFirstDecoration extends StatelessWidget {
  const BackgroundFirstDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -60.h,
      right: -40.w,
      child: Container(
        width: 200.w,
        height: 200.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.primary.withValues(alpha: 0.07),
        ),
      ),
    );
  }
}

class BackgroundSecondDecoration extends StatelessWidget {
  const BackgroundSecondDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80.h,
      right: -60.w,
      child: Container(
        width: 220.w,
        height: 220.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:context.colorScheme.secondary.withValues(alpha: 0.06),
        ),
      ),
    );
  }
}
