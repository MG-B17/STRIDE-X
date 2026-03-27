import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/text_styles.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class StepPerformanceCard extends StatelessWidget {
  const StepPerformanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.stepPerformance,
                style: _labelStyle(context),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.kineticGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: AppColors.kineticGreen, size: 12.sp),
                    const HorizantilSpacingWidget(value: 4),
                    Text(
                      AppStrings.defaultStepIncrease,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kineticGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VerticalSpacingWidget(value: 8),
          Text(
            AppStrings.defaultAvgSteps,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 36.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.kineticGreen,
              height: 1.1,
            ),
          ),
          Text(
            AppStrings.avgPerDay,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const VerticalSpacingWidget(value: 24),
          SizedBox(
            height: 100.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...[0.4, 0.5, 0.7, 0.6, 1.0, 0.8, 0.5].map((val) => Container(
                      width: 8.w,
                      height: 80.h * val,
                      decoration: BoxDecoration(
                        color: val == 1.0
                            ? AppColors.kineticGreen
                            : AppColors.kineticGreen.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    )),
              ],
            ),
          ),
          const VerticalSpacingWidget(value: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: AppStrings.weekDays
                .asMap().entries.map((e) => Text(
                      e.value,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 10.sp,
                        fontWeight: e.key == 4 ? FontWeight.w800 : FontWeight.w600, 
                        color: e.key == 4
                            ? AppColors.kineticGreen
                            : context.colorScheme.onSurface.withValues(alpha: 0.5),
                        letterSpacing: 1,
                      ),
                    ))
                .toList(),
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


