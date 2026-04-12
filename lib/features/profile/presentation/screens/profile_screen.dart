import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/core/widgets/stride_x_app_bar.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_cubit.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_states.dart';
import 'package:stridex/features/profile/presentation/widgets/daily_goal_card.dart';
import 'package:stridex/features/profile/presentation/widgets/notifications_card.dart';
import 'package:stridex/core/widgets/section_header_widget.dart';
import 'package:stridex/features/profile/presentation/widgets/stride_accurate_widget.dart';
import 'package:stridex/features/profile/presentation/widgets/theme_selection_card.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StrideXAppBar(),
              const SectionHeaderWidget(
                title: AppStrings.accountSettings,
                trailingText: AppStrings.personalization,
              ),
              BlocBuilder<StepCounterCubit, StepCounterState>(
                buildWhen: (prev, curr) {
                  if (prev is Loaded && curr is Loaded) {
                    return prev.progressStep != curr.progressStep ||
                        prev.goalStep != curr.goalStep;
                  }
                  return prev.runtimeType != curr.runtimeType;
                },
                builder: (context, state) {
                  String goalSteps = CachedData.userPhysicalData.stepGoal.toString();
                  double progress = 0.0;
                  if (state is Loaded) {
                    goalSteps = state.goalStep.toString();
                    progress = state.progressStep;
                  }
                  return DailyGoalCard(
                    steps: goalSteps,
                    progress: progress,
                  );
                },
              ),
              VerticalSpacingWidget(value: 16),
              const StrideAccurateWidget(),
              VerticalSpacingWidget(value: 16),
              const SectionHeaderWidget(
                title: AppStrings.notifications,
                icon: Icons.notifications_none_outlined,
              ),
              const NotificationsCard(),
              const SectionHeaderWidget(title: AppStrings.visualTheme),
              const ThemeSelectionCard(),
              VerticalSpacingWidget(value: 16),
            ],
          ),
        ),
      ),
    );
  }
}



