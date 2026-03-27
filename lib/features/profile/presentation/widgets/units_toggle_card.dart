import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class UnitsToggleCard extends StatefulWidget {
  const UnitsToggleCard({super.key});

  @override
  State<UnitsToggleCard> createState() => _UnitsToggleCardState();
}

class _UnitsToggleCardState extends State<UnitsToggleCard> {
  bool isMetric = true;

  Widget _buildToggleTab(String label, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMetric = label == AppStrings.metricKm;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? context.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            label,
            style: context.textTheme.labelLarge?.copyWith(
              color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

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
              Icon(Icons.straighten_rounded, color: context.colorScheme.primary, size: 20.sp),
              Text(
                AppStrings.units,
                style: context.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          VerticalSpacingWidget(value: 16),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: isDark ? Colors.black.withValues(alpha: 0.2) : context.colorScheme.onSurface.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                _buildToggleTab(AppStrings.metricKm, isMetric),
                _buildToggleTab(AppStrings.imperialMi, !isMetric),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
