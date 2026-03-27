import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/utils/extentions.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final String? trailingText;
  final IconData? icon;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.trailingText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, top: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: context.colorScheme.primary, size: 20.sp),
                SizedBox(width: 8.w),
              ],
              Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (trailingText != null)
            Text(
              trailingText!,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10.sp,
                letterSpacing: 1.2,
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
        ],
      ),
    );
  }
}
