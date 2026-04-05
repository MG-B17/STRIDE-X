import 'package:flutter/material.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/calibration/presentation/widgets/text_form_widget.dart';

class PhysicSCard extends StatelessWidget {
  const PhysicSCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = CalibrationCubit.get(context);
    
    return Column(
      children: [
        Row(
          children: [
            TextFormWidget(
              icon: Icons.straighten_rounded,
              label: AppStrings.height,
              controller: cubit.heightController,
              unit: AppStrings.cm,
            ),
            HorizantilSpacingWidget(value: 12),
            TextFormWidget(
              icon: Icons.monitor_weight_rounded,
              label: AppStrings.weight,
              controller: cubit.weightController,
              unit: AppStrings.kg,
            ),
          ],
        ),
      ],
    );
  }
}
