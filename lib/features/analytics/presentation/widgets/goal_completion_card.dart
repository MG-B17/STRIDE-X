import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/text_styles.dart';

class GoalCompletionCard extends StatelessWidget {
  const GoalCompletionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _AnalyticsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.goalCompletion, style: _labelStyle(context)),
          const VerticalSpacingWidget(value: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.defaultGoalPercent,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.pulseBlue,
                    ),
                  ),
                  const VerticalSpacingWidget(value: 4),
                  Text(
                    AppStrings.defaultGoalDays,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12.sp,
                      color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 48.w,
                height: 48.w,
                child: CircularProgressIndicator(
                  value: 0.71,
                  strokeWidth: 6.w,
                  backgroundColor: context.colorScheme.onSurface.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.pulseBlue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _labelStyle(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 10.sp,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
      color: context.colorScheme.onSurface.withValues(alpha: 0.5),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final Widget child;
  const _AnalyticsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = context.colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceGreen : colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isDark ? AppColors.borderStrokeDark : AppColors.borderStrokeLight,
        ),
      ),
      child: child,
    );
  }
}
