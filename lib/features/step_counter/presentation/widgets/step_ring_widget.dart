import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'dart:math' as math;
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_cubit.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_states.dart';
import 'package:stridex/features/step_counter/presentation/widgets/animated_steps_text.dart';

class StepRingWidget extends StatelessWidget {
  const StepRingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return BlocBuilder<StepCounterCubit, StepCounterState>(
      buildWhen: (prev, curr) {
        if (prev is Loaded && curr is Loaded) {
          return prev.dailyStep != curr.dailyStep ||
              prev.progressStep != curr.progressStep;
        }
        return prev.runtimeType != curr.runtimeType;
      },
      builder: (context, state) {
        if (state is Loaded) {
          return Center(
            child: SizedBox(
              width: 200.w,
              height: 200.w,
              child: CustomPaint(
                painter: _RingPainter(progress: state.progressStep),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedStepsText(
                      targetStep: state.dailyStep,
                      formatter: (val) => val.formatWithCommas(),
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: 38.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                      ),
                    ),
                    const VerticalSpacingWidget(value: 2),
                    Text(
                      AppStrings.steps,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: colorScheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                    const VerticalSpacingWidget(value: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.actionGradient,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        '${(state.progressStep * 100).toInt()}% ${AppStrings.complete}',
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is Error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.surfaceGreen
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..shader = AppColors.actionGradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
