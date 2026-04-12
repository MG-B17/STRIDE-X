import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/constant/stride_enum.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/stride_card.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_states.dart';

class GenderCard extends StatelessWidget {
  const GenderCard({super.key});

  Widget _buildGenderButton(BuildContext context, Gender gender, Gender selectedGender) {
    final isSelected = selectedGender == gender;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          CalibrationCubit.get(context).selectGender(gender);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            gender.name.toUpperCase(),
            style: textTheme.labelLarge?.copyWith(
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalibrationCubit, CalibrationState>(
      builder: (context, state) {
        final cubit = CalibrationCubit.get(context);
        final selectedGender = cubit.selectedGender;
        
        return StrideCard(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.biologicalGender,
                style: context.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              VerticalSpacingWidget(value: 20),
              Row(
                children: [
                  _buildGenderButton(context, Gender.male, selectedGender),
                  HorizantilSpacingWidget(value: 12),
                  _buildGenderButton(context, Gender.female, selectedGender),
                  HorizantilSpacingWidget(value: 12),
                  _buildGenderButton(context, Gender.other, selectedGender),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}



