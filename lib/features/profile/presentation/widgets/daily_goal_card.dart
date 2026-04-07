import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

import 'package:stridex/core/widgets/stride_card.dart';

class DailyGoalCard extends StatelessWidget {
  const DailyGoalCard({super.key, required this.steps, required this.progress});
  final String steps;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.flag_outlined, color: context.colorScheme.primary, size: 20.sp),
              Text(
                AppStrings.dailyGoal,
                style: context.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          VerticalSpacingWidget(value: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 8.w,
            children: [
              Text(
                steps,
                style: context.textTheme.headlineLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontSize: 32.sp,
                  height: 1.0,
                ),
              ),           
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  'steps',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
          VerticalSpacingWidget(value: 16),
          // Progress Bar
          Container(
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colorScheme.onSurface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                  gradient: const LinearGradient(
                    colors: [AppColors.kineticGreen, AppColors.pulseBlue],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
