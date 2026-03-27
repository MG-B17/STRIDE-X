import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/text_styles.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class TotalWeeklyStepsCard extends StatelessWidget {
  const TotalWeeklyStepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.totalWeeklySteps, style: _labelStyle(context)),
          const VerticalSpacingWidget(value: 8),
          Row(
            children: [
              Text(
                AppStrings.defaultTotalSteps,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const HorizantilSpacingWidget(value: 8),
              Icon(Icons.directions_walk, color: AppColors.kineticGreen, size: 28.sp),
            ],
          ),
          const VerticalSpacingWidget(value: 16),
          Stack(
            children: [
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.7,
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: AppColors.kineticGreen,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _labelStyle(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 10.sp,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
      color: context.colorScheme.onSurface.withValues(alpha: 0.5),
    );
  }
}


