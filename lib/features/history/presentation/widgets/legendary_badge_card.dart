import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class LegendaryBadgeCard extends StatelessWidget {
  final bool isUnlocked;
  const LegendaryBadgeCard({super.key, required this.isUnlocked});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.45,
      child: StrideCard(
        padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // Background Trophy Icon
            Positioned(
              right: -20.w,
              bottom: -20.h,
              child: Icon(
                Icons.emoji_events,
                size: 140.sp,
                color: context.colorScheme.onSurface.withValues(alpha: 0.03),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  // Star Icon Box
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.star_rounded,
                      color: Colors.black, // High contrast with amber
                      size: 32.sp,
                    ),
                  ),
                  const HorizantilSpacingWidget(value: 16),
                  
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            AppStrings.legendary,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.amber,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const VerticalSpacingWidget(value: 6),
                        Text(
                          AppStrings.summitSeeker,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                        const VerticalSpacingWidget(value: 4),
                        Text(
                          AppStrings.summitSeekerDesc,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
