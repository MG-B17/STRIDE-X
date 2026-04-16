import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/features/layout/widgets/stride_bottom_nav_bar_item.dart';
import 'package:stridex/core/di/injection.dart'as di ;
import 'package:stridex/features/step_counter/presentation/controller/step_counter_cubit.dart';
import 'package:stridex/core/utils/app_lifecycle_handler.dart';

class LayoutScreen extends StatefulWidget {
  final StatefulNavigationShell shell;
  const LayoutScreen({super.key, required this.shell});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  late StepCounterCubit _stepCounterCubit;
  late AppLifecycleHandler _lifecycleHandler;

  @override
  void initState() {
    super.initState();
    _stepCounterCubit = di.init<StepCounterCubit>()..startStepsStream();
    _lifecycleHandler = AppLifecycleHandler(
      onPaused: () => _stepCounterCubit.saveTodaySteps(),
      onResumed: () => _stepCounterCubit.restoreTodaySteps(),
    );
  }

  @override
  void dispose() {
    _lifecycleHandler.dispose();
    _stepCounterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: _stepCounterCubit,
      child: Scaffold(
        body: widget.shell,
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
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
                currentIndex: widget.shell.currentIndex,
                icon: Icons.home_outlined,
                label: AppStrings.navHome,
                onTap: (i) {
                  widget.shell.goBranch(i, initialLocation: i == widget.shell.currentIndex);
                },
              ),
              BottomNavItem(
                index: 1,
                currentIndex: widget.shell.currentIndex,
                icon: Icons.insights,
                label: AppStrings.navAnalytics,
                onTap: (i) {
                  widget.shell.goBranch(i, initialLocation: i == widget.shell.currentIndex);
                },
              ),
              BottomNavItem(
                index: 2,
                currentIndex: widget.shell.currentIndex,
                icon: Icons.history,
                label: AppStrings.navHistory,
                onTap: (i) {
                  widget.shell.goBranch(i, initialLocation: i == widget.shell.currentIndex);
                },
              ),
              BottomNavItem(
                index: 3,
                currentIndex: widget.shell.currentIndex,
                icon: Icons.person_outline,
                label: AppStrings.navProfile,
                onTap: (i) {
                  widget.shell.goBranch(i, initialLocation: i == widget.shell.currentIndex);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
