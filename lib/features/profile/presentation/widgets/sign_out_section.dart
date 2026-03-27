import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class SignOutSection extends StatelessWidget {
  const SignOutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacingWidget(value: 32),
        // Divider
        Center(
          child: Container(
            width: 48.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: context.colorScheme.onSurface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
        ),
        VerticalSpacingWidget(value: 24),
        // Sign Out Button
        GestureDetector(
          onTap: () {
            // Handle sign out
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout_rounded, color: AppColors.danger, size: 20.sp),
              HorizantilSpacingWidget(value: 8),
              Text(
                AppStrings.signOut,
                style: context.textTheme.labelLarge?.copyWith(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        VerticalSpacingWidget(value: 12),
        // App Version
        Text(
          AppStrings.appVersion,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.4),
            fontSize: 10.sp,
          ),
        ),
        VerticalSpacingWidget(value: 40), // Bottom padding
      ],
    );
  }
}
