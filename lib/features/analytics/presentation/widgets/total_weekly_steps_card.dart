import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/text_styles.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class TotalWeeklyStepsCard extends StatelessWidget {
  final int totalWeeklySteps;
  const TotalWeeklyStepsCard({
    super.key,
    required this.totalWeeklySteps,
  });

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.totalWeeklySteps, style: context.analyticsLabelStyle),
          const VerticalSpacingWidget(value: 8),
          Row(
            children: [
              Text(
                totalWeeklySteps.formatWithCommas(),
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
                widthFactor: 1.0, // Represents max context inside this card
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
}



