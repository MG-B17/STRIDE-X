import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/theme/text_styles.dart';

class AnalyticsHeader extends StatelessWidget {
  final String title;
  final bool isWeekly;
  final VoidCallback onWeeklyTap;
  final VoidCallback onMonthlyTap;

  const AnalyticsHeader({
    super.key,
    required this.title,
    required this.isWeekly,
    required this.onWeeklyTap,
    required this.onMonthlyTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = context.colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.headlineLarge,
        ),
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark
                ? AppColors.surfaceGreen
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            children: [
              _ToggleButton(
                text: 'Weekly',
                isSelected: isWeekly,
                onTap: onWeeklyTap,
              ),
              _ToggleButton(
                text: 'Monthly',
                isSelected: !isWeekly,
                onTap: onMonthlyTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kineticGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.kineticGreen.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: isSelected
                ? AppColors.backgroundDark
                : theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
