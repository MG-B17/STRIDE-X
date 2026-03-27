import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/text_styles.dart';

class ConsistencySection extends StatelessWidget {
  const ConsistencySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
          child: Text(
            AppStrings.dailyConsistency,
            style: context.textTheme.headlineMedium?.copyWith(
              fontSize: 20.sp,
              height: 1.2,
            ),
          ),
        ),
        _ConsistencyRow(
          color: AppColors.kineticGreen,
          label: AppStrings.goalReached,
          days: '3 Days',
          isDark: isDark,
        ),
        const VerticalSpacingWidget(value: 8),
        _ConsistencyRow(
          color: AppColors.warning,
          label: AppStrings.nearGoal,
          days: '2 Days',
          isDark: isDark,
        ),
        const VerticalSpacingWidget(value: 8),
        _ConsistencyRow(
          color: AppColors.danger,
          label: AppStrings.belowGoal,
          days: '2 Days',
          isDark: isDark,
        ),
      ],
    );
  }
}

class _ConsistencyRow extends StatelessWidget {
  final Color color;
  final String label;
  final String days;
  final bool isDark;

  const _ConsistencyRow({
    required this.color,
    required this.label,
    required this.days,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceGreen : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.borderStrokeDark : AppColors.borderStrokeLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const HorizantilSpacingWidget(value: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: context.colorScheme.onSurface,
              ),
            ),
          ),
          Text(
            days,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
