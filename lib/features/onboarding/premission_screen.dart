import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/theme/text_styles.dart';

class PremissionScreen extends StatelessWidget {
  const PremissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Ambient glow orbs
            Positioned(
              top: -60.h,
              right: -40.w,
              child: Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: 0.07),
                ),
              ),
            ),
            Positioned(
              bottom: 80.h,
              right: -60.w,
              child: Container(
                width: 220.w,
                height: 220.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.secondary.withValues(alpha: 0.06),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),

                  // Green accent line
                  Container(
                    width: 36.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      gradient: AppColors.actionGradient,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Headline
                  Text(
                    'Give StrideX a\nBoost.',
                    style: textTheme.headlineLarge?.copyWith(
                      fontSize: 36.sp,
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Subtitle
                  Text(
                    'To track your steps accurately and keep you motivated, '
                    'we need access to your activity and notifications.',
                    style: textTheme.bodyMedium,
                  ),

                  SizedBox(height: 40.h),

                  // Permission cards
                  _PermissionCard(
                    icon: Icons.directions_run_rounded,
                    iconBgColor: colorScheme.primary,
                    title: 'Physical Activity',
                    description:
                        'Sync your real-time step data and movement patterns for precise tracking.',
                  ),

                  SizedBox(height: 12.h),

                  _PermissionCard(
                    icon: Icons.notifications_active_rounded,
                    iconBgColor: const Color(0xFF4B5EAA),
                    title: 'Smart Alerts',
                    description:
                        'Receive daily milestones, workout reminders, and kinetic coaching tips.',
                  ),

                  const Spacer(),

                  // Allow button
                  GestureDetector(
                    onTap: () =>
                        context.goNamed(AppRouteConstant.homeScreenRoute),
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: AppColors.actionGradient,
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Allow Permissions',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: colorScheme.onPrimary,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Maybe later
                  GestureDetector(
                    onTap: () =>
                        context.goNamed(AppRouteConstant.layoutScreenRoute),
                    child: Center(
                      child: Text(
                        'Maybe later',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Encrypted badge
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          size: 13.sp,
                          color: colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'END-TO-END ENCRYPTED DATA',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.4,
                            color: colorScheme.onSurface
                                .withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Permission card — theme-aware
// ---------------------------------------------------------------------------
class _PermissionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;

  const _PermissionCard({
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceGreen
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? AppColors.borderStrokeDark
              : AppColors.borderStrokeLight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: iconBgColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconBgColor, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.headlineSmall?.copyWith(fontSize: 15.sp),
                ),
                SizedBox(height: 4.h),
                Text(description, style: textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}