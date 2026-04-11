import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/text_styles.dart';

import 'package:stridex/core/widgets/stride_card.dart';

class ActiveBurnCard extends StatelessWidget {
  final double averageBurn;

  const ActiveBurnCard({
    super.key,
    required this.averageBurn,
  });

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.activeBurn, style: context.analyticsLabelStyle),
          const VerticalSpacingWidget(value: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                averageBurn.toInt().formatWithCommas(),
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.calories,
                ),
              ),
              const HorizantilSpacingWidget(value: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Text(
                  AppStrings.kcal,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ],
          ),
          const VerticalSpacingWidget(value: 16),
          Row(
            children: List.generate(5, (index) {
              return Expanded(
                child: Container(
                  height: 6.h,
                  margin: EdgeInsets.only(right: index < 4 ? 8.w : 0),
                  decoration: BoxDecoration(
                    color: index < 3
                        ? AppColors.calories
                        : context.colorScheme.onSurface.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
