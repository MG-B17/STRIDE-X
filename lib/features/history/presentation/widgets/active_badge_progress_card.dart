import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class ActiveBadgeProgressCard extends StatelessWidget {
  const ActiveBadgeProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceGreen : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.borderStrokeDark : AppColors.borderStrokeLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.marathoner,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                  VerticalSpacingWidget(value: 4),
                  Text(
                    AppStrings.activeBadgeProgress,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              Text(
                '70%',
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.kineticGreen,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          VerticalSpacingWidget(value: 20),
          
          // Progress Bar
          Container(
            height: 8.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colorScheme.onSurface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  gradient: const LinearGradient(
                    colors: [AppColors.pulseBlue, AppColors.kineticGreen],
                  ),
                ),
              ),
            ),
          ),
          VerticalSpacingWidget(value: 12),
          
          // Limits Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.sevenThousandSteps,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                AppStrings.tenThousandStepsGoal,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
