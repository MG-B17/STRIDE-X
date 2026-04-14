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
import 'package:stridex/features/step_counter/presentation/widgets/weekly_progress_widget.dart';

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
                buildWhen: (prev, curr) {
                  if (prev is Loaded && curr is Loaded) {
                    return prev.calories != curr.calories ||
                        prev.distance != curr.distance;
                  }
                  return prev.runtimeType != curr.runtimeType;
                },
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
              const VerticalSpacingWidget(value: 28),
              BlocBuilder<StepCounterCubit, StepCounterState>(
                buildWhen: (prev, curr) {
                  if (prev is Loaded && curr is Loaded) {
                    return prev.weeklyValues != curr.weeklyValues ||
                        prev.activeIndex != curr.activeIndex;
                  }
                  return prev.runtimeType != curr.runtimeType;
                },
                builder: (context, state) {
                  List<double> values = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                  int activeIndex = DateTime.now().weekday - 1;

                  if (state is Loaded) {
                    values = state.weeklyValues;
                    activeIndex = state.activeIndex;
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: WeeklyProgressWidget(
                      values: values,
                      activeIndex: activeIndex,
                    ),
                  );
                },
              ),
              const VerticalSpacingWidget(value: 28),
            ],
          ),
        ),
      ),
    );
  }
}
