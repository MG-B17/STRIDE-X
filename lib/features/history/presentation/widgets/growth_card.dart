import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

import 'package:stridex/core/widgets/stride_card.dart';

class GrowthCard extends StatelessWidget {
  final double growthPercent;

  const GrowthCard({super.key, required this.growthPercent});

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.trending_up_rounded,
            color: AppColors.kineticGreen,
            size: 28.sp,
          ),
          VerticalSpacingWidget(value: 12),
          Text(
            '${growthPercent >= 0 ? '+' : ''}${growthPercent.toStringAsFixed(1)}%',
            style: context.textTheme.headlineMedium?.copyWith(
              color: AppColors.kineticGreen,
              fontWeight: FontWeight.w800,
              fontSize: 24.sp,
              height: 1.0,
            ),
          ),
          VerticalSpacingWidget(value: 8),
          Text(
            AppStrings.historyGrowthDesc,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              letterSpacing: 1.5,
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}



