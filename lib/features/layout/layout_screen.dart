import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/features/layout/widgets/stride_bottom_nav_bar_item.dart';

class LayoutScreen extends StatelessWidget {
  final StatefulNavigationShell shell;
  const LayoutScreen({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: shell,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 12.h,
          bottom: ScreenUtil().bottomBarHeight > 0
              ? ScreenUtil().bottomBarHeight
              : 16.h,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outlineVariant,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavItem(
              index: 0,
              currentIndex: shell.currentIndex,
              icon: Icons.home_outlined,
              label: AppStrings.navHome,
              onTap: (i) {
                shell.goBranch(i, initialLocation: i == shell.currentIndex);
              },
            ),
            BottomNavItem(
              index: 1,
              currentIndex: shell.currentIndex,
              icon: Icons.insights,
              label: AppStrings.navAnalytics,
              onTap: (i) {
                shell.goBranch(i, initialLocation: i == shell.currentIndex);
              },
            ),
            BottomNavItem(
              index: 2,
              currentIndex: shell.currentIndex,
              icon: Icons.history,
              label: AppStrings.navHistory,
              onTap: (i) {
                shell.goBranch(i, initialLocation: i == shell.currentIndex);
              },
            ),
            BottomNavItem(
              index: 3,
              currentIndex: shell.currentIndex,
              icon: Icons.person_outline,
              label: AppStrings.navProfile,
              onTap: (i) {
                shell.goBranch(i, initialLocation: i == shell.currentIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}
