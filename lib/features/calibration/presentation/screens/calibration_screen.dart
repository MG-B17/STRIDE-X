import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/di/injection.dart' as di;
import 'package:stridex/core/widgets/stride_card.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_states.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/calibration/presentation/widgets/calibration_success_button.dart';
import 'package:stridex/features/calibration/presentation/widgets/calibration_success_widget.dart';
import 'package:stridex/features/calibration/presentation/widgets/stride_calibration_widget.dart';
import 'package:stridex/features/calibration/presentation/widgets/calibration_content_widget.dart';
import 'package:stridex/features/calibration/presentation/widgets/calibration_progress_widget.dart';
import 'package:stridex/features/calibration/presentation/widgets/complete_calibration_button.dart';
import 'package:stridex/features/calibration/presentation/widgets/precision_guaranteed_text.dart';

class CalibrationScreen extends StatefulWidget {
  const CalibrationScreen({super.key});

  @override
  State<CalibrationScreen> createState() => _CalibrationScreenState();
}

class _CalibrationScreenState extends State<CalibrationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalibrationCubit>(
      create: (BuildContext context) {
        return di.init<CalibrationCubit>();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const StrideCalibrationWidget(),
              SizedBox(height: 16.h),
              StrideCard(
                child: BlocConsumer<CalibrationCubit, CalibrationState>(
                  listener: (context, state) {
                    if (state is CalibrationFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is CalibrationStreamFail) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return _buildCalibrationContent(
                      state: state,
                      context: context,
                    );
                  },
                ),
              ),
              BlocBuilder<CalibrationCubit, CalibrationState>(
                builder: (context, state) {
                  if (state is CalibrationLoading ||
                      state is CalibrationStreamSuccess) {
                    return CompleteCalibrationButton(
                      onPressed: () {
                    CalibrationCubit.get(context).finishCalibration();
                      },
                    );
                  } else if (state is CalibrationSuccess) {
                    return CalibrationSuccessButton();
                  }
                  return const SizedBox.shrink();
                },
              ),
              const PrecisionGuaranteedText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalibrationContent({
    required CalibrationState state,
    required BuildContext context,
  }) {
    if (state is CalibrationInitial || state is CalibrationFailure) {
      return CalibrationContentWidget(
        onNext: () {
          CalibrationCubit.get(context).startListening();
        },
      );
    } else if (state is CalibrationLoading ||
        state is CalibrationStreamSuccess) {
      return const CalibrationProgressWidget();
    } else if (state is CalibrationStreamFail) {
      return Text(state.message);
    } else if (state is CalibrationSuccess) {
      return CalibrationSuccessWidget();
    } else {
      return const SizedBox.shrink();
    }
  }
}
