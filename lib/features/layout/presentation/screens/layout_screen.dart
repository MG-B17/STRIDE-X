import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/di/injection.dart' as di;
import 'package:stridex/features/step_counter/presentation/controller/step_counter_cubit.dart';
import 'package:stridex/features/step_counter/presentation/screens/home_screen.dart';
import 'package:stridex/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:stridex/features/history/presentation/screens/history_screen.dart';
import 'package:stridex/features/profile/presentation/screens/profile_screen.dart';
import 'package:stridex/features/layout/presentation/widgets/bottom_nav_item.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 1;

  final List<Widget> _screens = [
     HomeScreen(),
    const AnalyticsScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>di.init<StepCounterCubit>()..startStepsStream(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
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
                currentIndex: _currentIndex,
                icon: Icons.home_outlined,
                label: AppStrings.navHome,
                onTap: (i) => setState(() => _currentIndex = i),
              ),
              BottomNavItem(
                index: 1,
                currentIndex: _currentIndex,
                icon: Icons.insights,
                label: AppStrings.navAnalytics,
                onTap: (i) => setState(() => _currentIndex = i),
              ),
              BottomNavItem(
                index: 2,
                currentIndex: _currentIndex,
                icon: Icons.history,
                label: AppStrings.navHistory,
                onTap: (i) => setState(() => _currentIndex = i),
              ),
              BottomNavItem(
                index: 3,
                currentIndex: _currentIndex,
                icon: Icons.person_outline,
                label: AppStrings.navProfile,
                onTap: (i) => setState(() => _currentIndex = i),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
