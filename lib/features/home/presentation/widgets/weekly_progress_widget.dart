import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/theme/text_styles.dart';

class WeeklyProgressWidget extends StatelessWidget {
  final List<double> values;
  final int activeIndex;

  const WeeklyProgressWidget({
    super.key,
    required this.values,
    required this.activeIndex,
  });

  static const _days = AppStrings.shortDays;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.weeklyProgressTitle, style: textTheme.headlineSmall),
                const VerticalSpacingWidget(value: 2),
                Text(
                  AppStrings.weeklyProgressSubtitle,
                  style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
            Icon(Icons.trending_up_rounded,
                color: colorScheme.primary, size: 22.sp),
          ],
        ),
        const VerticalSpacingWidget(value: 20),
        SizedBox(
          height: 100.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(values.length, (i) {
              final isActive = i == activeIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          heightFactor: values[i].clamp(0.08, 1.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutCubic,
                            decoration: BoxDecoration(
                              gradient: isActive
                                  ? AppColors.actionGradient
                                  : LinearGradient(
                                      colors: isDark
                                          ? [
                                              const Color(0xFF1A4D2E),
                                              const Color(0xFF0D2918)
                                            ]
                                          : [
                                              AppColors.kineticGreen
                                                  .withValues(alpha: 0.18),
                                              AppColors.kineticGreen
                                                  .withValues(alpha: 0.08),
                                            ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpacingWidget(value: 6),
                      Text(
                        _days[i],
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 11.sp,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isActive
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
