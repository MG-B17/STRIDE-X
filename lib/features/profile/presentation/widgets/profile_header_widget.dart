import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/profile/presentation/widgets/profile_image.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key,required this.name,required this.image,required this.level});
  final String name ;
  final String level;
  final String image ;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    
    return Column(
      children: [
        VerticalSpacingWidget(value: 24),
        ProfileImage(image: image),
        VerticalSpacingWidget(value: 16),
        // Name
        Text(
          name,
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 26.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        VerticalSpacingWidget(value: 8),
        // Title Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.kineticGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.workspace_premium_rounded, color: AppColors.kineticGreen, size: 14.sp),
              HorizantilSpacingWidget(value: 4),
              Text(
                "Level $level Walker",
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.kineticGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        VerticalSpacingWidget(value: 12),
        // Bio
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            AppStrings.profileBio,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}
