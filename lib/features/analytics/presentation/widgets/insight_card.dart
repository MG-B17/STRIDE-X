import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class InsightCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final InlineSpan content;

  const InsightCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return _AnalyticsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24.sp),
          const VerticalSpacingWidget(value: 12),
          Text(
            title,
            style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: 18.sp,
                ),
          ),
          const VerticalSpacingWidget(value: 8),
          RichText(
            text: TextSpan(
              style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
              children: [content],
            ),
          ),
        ],
      ),
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
