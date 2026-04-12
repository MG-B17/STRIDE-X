import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';

class PrecisionGuaranteedText extends StatelessWidget {
  const PrecisionGuaranteedText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, bottom: 40.h),
      child: Center(
        child: Text(
          AppStrings.precisionGuaranteed,
          textAlign: TextAlign.center,
          style: context.textTheme.labelSmall?.copyWith(
            letterSpacing: 1.2,
            color: context.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}



