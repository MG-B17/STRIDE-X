import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_x_app_bar.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_cubit.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_states.dart';
import 'package:stridex/features/step_counter/presentation/widgets/step_ring_widget.dart';
import 'package:stridex/features/step_counter/presentation/widgets/motivational_text_widget.dart';
import 'package:stridex/features/step_counter/presentation/widgets/home_stat_card.dart';
import 'package:stridex/features/step_counter/presentation/widgets/active_time_card.dart';
import 'package:stridex/features/step_counter/presentation/widgets/weekly_progress_widget.dart';
import 'package:stridex/features/step_counter/presentation/widgets/latest_workout_card.dart';

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
              const StepRingWidget(),
              const VerticalSpacingWidget(value: 16),
              const MotivationalTextWidget(),
              const VerticalSpacingWidget(value: 28),
              BlocBuilder<StepCounterCubit, StepCounterState>(
                builder: (context, state) {
                  String calValue = '0';
                  String kmValue = '0.00';
                  
                  if (state is Loaded) {
                    calValue = state.calories.toStringAsFixed(0);
                    kmValue = state.distance.toStringAsFixed(2);
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeStatCard(
                            iconPath: 'assets/svg/cal_icon.svg',
                            value: calValue,
                            label: AppStrings.kcalBurned,
                          ),
                        ),
                        const HorizantilSpacingWidget(value: 12),
                        Expanded(
                          child: HomeStatCard(
                            iconPath: 'assets/svg/km_icon.svg',
                            value: kmValue,
                            label: AppStrings.kmDistance,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const VerticalSpacingWidget(value: 12),
              BlocBuilder<StepCounterCubit, StepCounterState>(
                builder: (context, state) {
                  String activeTimeString = '0m';
                  if (state is Loaded) {
                    final int totalMinutes = state.activeTime;
                    if (totalMinutes < 1) {
                      activeTimeString = '0m';
                    } else if (totalMinutes < 60) {
                      activeTimeString = '${totalMinutes}m';
                    } else {
                      final int h = totalMinutes ~/ 60;
                      final int m = totalMinutes % 60;
                      activeTimeString = '${h}h ${m}m';
                    }
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ActiveTimeCard(
                      iconPath: 'assets/svg/timer_icon.svg',
                      activeTime: activeTimeString,
                    ),
                  );
                },
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
