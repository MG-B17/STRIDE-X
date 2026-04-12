import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_card.dart';
import 'package:stridex/core/widgets/stride_x_app_bar.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/calibration/presentation/widgets/calibration_content_widget.dart';
import 'package:stridex/features/calibration/presentation/widgets/gender_card.dart';
import 'package:stridex/features/calibration/presentation/widgets/physic_scard.dart';
import 'package:stridex/features/calibration/presentation/widgets/precision_guaranteed_text.dart';
import 'package:stridex/features/calibration/presentation/widgets/set_step_goal_widget.dart';
import 'package:stridex/features/calibration/presentation/widgets/stride_calibration_widget.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key});

  void _nextScreen(BuildContext context) {
    context.goNamed(AppRouteConstant.calibrationScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const StrideXAppBar(),
                const VerticalSpacingWidget(value: 12),
                const PhysicSCard(),
                const VerticalSpacingWidget(value: 12),
                const GenderCard(),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: const Row(children: [SetStepGoalWidget()]),
                ),
                const VerticalSpacingWidget(value: 24),
                const StrideCalibrationWidget(),
                const VerticalSpacingWidget(value: 16),
                StrideCard(
                  child: CalibrationContentWidget(
                    onNext: () {
                      _nextScreen(context);
                      CalibrationCubit.get(context).saveUserData();
                    },
                  ),
                ),
                const VerticalSpacingWidget(value: 24),
                const PrecisionGuaranteedText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



