import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/theme/text_styles.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_cubit.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_states.dart';

class MotivationalTextWidget extends StatelessWidget {
  const MotivationalTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return BlocBuilder<StepCounterCubit, StepCounterState>(
      builder: (context, state) {
        if (state is Loaded) {
          final int remaining = state.goalStep - state.dailyStep;
          final bool isGoalReached = remaining <= 0;

          return Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: isGoalReached 
                        ? "Amazing! Goal Reached!" 
                        : AppStrings.crushingIt,
                  ),
                  if (!isGoalReached) ...[
                    TextSpan(
                      text: '\n ${_fmt(remaining)} steps',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: AppStrings.toYourGoal),
                  ],
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  String _fmt(int n) {
    final s = n.toString();
    return n >= 1000
        ? '${s.substring(0, s.length - 3)},${s.substring(s.length - 3)}'
        : s;
  }
}
