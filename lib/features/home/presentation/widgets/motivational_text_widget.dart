import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/theme/text_styles.dart';

class MotivationalTextWidget extends StatelessWidget {
  const MotivationalTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: textTheme.bodyLarge,
          children: [
            const TextSpan(text: AppStrings.crushingIt),
            TextSpan(
              text: AppStrings.onlyStepsCount,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),
            const TextSpan(text: AppStrings.toYourGoal),
          ],
        ),
      ),
    );
  }
}
