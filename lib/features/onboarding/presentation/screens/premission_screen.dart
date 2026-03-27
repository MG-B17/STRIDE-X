import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/app_button.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/onboarding/presentation/widgets/premission_widget/background_decoration.dart';
import 'package:stridex/features/onboarding/presentation/widgets/premission_widget/premission_card.dart';
import 'package:stridex/features/onboarding/presentation/widgets/premission_widget/premission_tittle_sub_tittle.dart';

class PremissionScreen extends StatelessWidget {
  const PremissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundFirstDecoration(),
            BackgroundSecondDecoration(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: [
                  VerticalSpacingWidget(value: 40),
                  PremissionTittleAndSubTittle(),
                  PremissionCard(
                    icon: Icons.directions_run_rounded,
                    iconBgColor: colorScheme.primary,
                    title: AppStrings.physicalActivityTitle,
                    description: AppStrings.physicalActivityDesc,
                  ),
                  PremissionCard(
                    icon: Icons.notifications_active_rounded,
                    iconBgColor: const Color(0xFF4B5EAA),
                    title: AppStrings.smartAlertsTitle,
                    description: AppStrings.smartAlertsDesc,
                  ),
                  // Allow button
                  AppButton(
                    onNext: () =>
                        context.goNamed(AppRouteConstant.layoutScreenRoute),
                    text: AppStrings.allowPermissions,
                  ),

                  // Maybe later
                  GestureDetector(
                    onTap: () =>
                        context.goNamed(AppRouteConstant.layoutScreenRoute),
                    child: Center(
                      child: Text(
                        AppStrings.maybeLater,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
