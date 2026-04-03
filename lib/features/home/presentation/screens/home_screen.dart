import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_x_app_bar.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/features/home/presentation/widgets/step_ring_widget.dart';
import 'package:stridex/features/home/presentation/widgets/motivational_text_widget.dart';
import 'package:stridex/features/home/presentation/widgets/home_stat_card.dart';
import 'package:stridex/features/home/presentation/widgets/active_time_card.dart';
import 'package:stridex/features/home/presentation/widgets/weekly_progress_widget.dart';
import 'package:stridex/features/home/presentation/widgets/latest_workout_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StrideXAppBar(),
              const VerticalSpacingWidget(value: 28),
              StepRingWidget(),
              const VerticalSpacingWidget(value: 16),
              const MotivationalTextWidget(),
              const VerticalSpacingWidget(value: 28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    const Expanded(
                      child: HomeStatCard(
                        iconPath: 'assets/svg/cal_icon.svg',
                        value: '342',
                        label: AppStrings.kcalBurned,
                      ),
                    ),
                    const HorizantilSpacingWidget(value: 12),
                    const Expanded(
                      child: HomeStatCard(
                        iconPath: 'assets/svg/km_icon.svg',
                        value: '5.2',
                        label: AppStrings.kmDistance,
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpacingWidget(value: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const ActiveTimeCard(iconPath: 'assets/svg/timer_icon.svg'),
              ),
              const VerticalSpacingWidget(value: 28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const WeeklyProgressWidget(
                  values: [0.55, 0.40, 0.70, 1.0, 0.60, 0.30, 0.45],
                  activeIndex: 3,
                ),
              ),
              const VerticalSpacingWidget(value: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const LatestWorkoutCard(),
              ),
              const VerticalSpacingWidget(value: 24),
            ],
          ),
        ),
      ),
    );
  }
}
