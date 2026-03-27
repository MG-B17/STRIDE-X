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
        const _ConsistencyRow(
          color: AppColors.kineticGreen,
          label: AppStrings.goalReached,
          days: '3 Days',
        ),
        const VerticalSpacingWidget(value: 8),
        const _ConsistencyRow(
          color: AppColors.warning,
          label: AppStrings.nearGoal,
          days: '2 Days',
        ),
        const VerticalSpacingWidget(value: 8),
        const _ConsistencyRow(
          color: AppColors.danger,
          label: AppStrings.belowGoal,
          days: '2 Days',
        ),
      ],
    );
  }
}

class _ConsistencyRow extends StatelessWidget {
  final Color color;
  final String label;
  final String days;

  const _ConsistencyRow({
    required this.color,
    required this.label,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
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
