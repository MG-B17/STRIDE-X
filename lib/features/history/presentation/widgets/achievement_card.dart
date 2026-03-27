import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/stride_card.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isUnlocked;

  const AchievementCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.isUnlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Box
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: isUnlocked 
                      ? iconColor.withValues(alpha: 0.15) 
                      : context.colorScheme.onSurface.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  icon,
                  color: isUnlocked 
                      ? iconColor 
                      : context.colorScheme.onSurface.withValues(alpha: 0.4),
                  size: 28.sp,
                ),
              ),
              if (isUnlocked)
                Positioned(
                  top: -4.h,
                  right: -4.w,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.kineticGreen,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(2.w),
                    child: Icon(
                      Icons.check,
                      size: 10.sp,
                      color: Colors.black, // Contrast color on green
                    ),
                  ),
                ),
            ],
          ),
          const VerticalSpacingWidget(value: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: isUnlocked 
                  ? context.colorScheme.onSurface
                  : context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const VerticalSpacingWidget(value: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 9.sp,
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
