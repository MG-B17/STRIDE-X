import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/text_styles.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class GoalCompletionCard extends StatelessWidget {
  final int goalReached;
  final int daysToAnalyze;
  
  const GoalCompletionCard({
    super.key,
    required this.goalReached,
    required this.daysToAnalyze,
  });

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.goalCompletion, style: context.analyticsLabelStyle),
          const VerticalSpacingWidget(value: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${((goalReached / (daysToAnalyze == 0 ? 1 : daysToAnalyze)) * 100).toInt()}%',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.pulseBlue,
                    ),
                  ),
                  const VerticalSpacingWidget(value: 4),
                  Text(
                    '$goalReached Days',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12.sp,
                      color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 48.w,
                height: 48.w,
                child: CircularProgressIndicator(
                  value: goalReached / (daysToAnalyze == 0 ? 1 : daysToAnalyze),
                  strokeWidth: 6.w,
                  backgroundColor: context.colorScheme.onSurface.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.pulseBlue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
