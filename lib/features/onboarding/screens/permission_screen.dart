import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/di/injection.dart' as di;
import 'package:stridex/core/services/activity_permission_service.dart';
import 'package:stridex/core/services/notification_permission_service.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/app_button.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/onboarding/widgets/permission_widget/background_decoration.dart';
import 'package:stridex/features/onboarding/widgets/permission_widget/permission_card.dart';
import 'package:stridex/features/onboarding/widgets/permission_widget/permission_title_sub_title.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  Future<void> _handleAllowPermissions() async {
    // Request Activity Recognition (Physical Activity)
    await di.init<ActivityPermissionService>().handlePermission();

    // Request Notification Permissions
    await di.init<NotificationPermissionService>().handlePermission();

    if (!mounted) return;
    context.goNamed(AppRouteConstant.userDataScreenRoute);
  }

  void _handleMaybeLater() {
    context.goNamed(AppRouteConstant.userDataScreenRoute);
  }

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
                  PermissionTittleAndSubTittle(),
                  PermissionCard(
                    icon: Icons.directions_run_rounded,
                    iconBgColor: colorScheme.primary,
                    title: AppStrings.physicalActivityTitle,
                    description: AppStrings.physicalActivityDesc,
                  ),
                  PermissionCard(
                    icon: Icons.notifications_active_rounded,
                    iconBgColor: const Color(0xFF4B5EAA),
                    title: AppStrings.smartAlertsTitle,
                    description: AppStrings.smartAlertsDesc,
                  ),
                  // Allow button
                  AppButton(
                    onNext: _handleAllowPermissions,
                    text: AppStrings.allowPermissions,
                  ),

                  // Maybe later
                  GestureDetector(
                    onTap: _handleMaybeLater,
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



