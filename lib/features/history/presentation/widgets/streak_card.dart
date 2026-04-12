import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/features/history/presentation/widgets/sub_state_container.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({super.key,required this.strak,required this.longestStreak,required this.totalWins});
  final int strak;
  final int longestStreak;
  final int totalWins;

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          // Flame Icon with Glow
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.kineticGreen.withValues(alpha: 0.5),
                width: 2.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kineticGreen.withValues(alpha: 0.2),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.pulseBlue, // Light blue/green flame based on image
              size: 40.sp,
            ),
          ),
          VerticalSpacingWidget(value: 16),
          // Streak Number
          Text(
            strak.toString(),
            style: context.textTheme.headlineLarge?.copyWith(
              fontSize: 56.sp,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
          VerticalSpacingWidget(value: 4),
          Text(
            AppStrings.dayStreak,
            style: context.textTheme.labelMedium?.copyWith(
              color: AppColors.kineticGreen,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          VerticalSpacingWidget(value: 24),
          // Sub-stats
          Row(
            children: [
              Expanded(
                child: SubStateContainer(label:AppStrings.longest,value:'$longestStreak Days'),
              ),
              HorizantilSpacingWidget(value: 12),
              Expanded(
                child: SubStateContainer(label:AppStrings.totalWins,value:"$totalWins"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



