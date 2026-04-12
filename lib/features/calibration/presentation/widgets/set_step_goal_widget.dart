import 'package:flutter/material.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/calibration/presentation/widgets/text_form_widget.dart';

class SetStepGoalWidget extends StatelessWidget {
  const SetStepGoalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormWidget(
      icon: Icons.flag_rounded,
      label: AppStrings.stepGoal,
      controller: CalibrationCubit.get(context).stepGoalController,
      unit: AppStrings.stepsUnit,
    );
  }
}



