import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/core/utils/cache_helper.dart';
import 'package:stridex/features/Calibration/presentation/screens/calibration_screen.dart';
import 'package:stridex/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/calibration/presentation/screens/user_data_screen.dart';
import 'package:stridex/features/history/presentation/screens/history_screen.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_cubit.dart';
import 'package:stridex/features/step_counter/presentation/screens/home_screen.dart';
import 'package:stridex/features/layout/layout_screen.dart';
import 'package:stridex/features/onboarding/screens/onboarding_screen.dart';
import 'package:stridex/features/onboarding/screens/permission_screen.dart';
import 'package:stridex/features/profile/presentation/screens/profile_screen.dart';
import 'package:stridex/features/splash/splash_screen.dart';
import 'package:stridex/core/di/injection.dart' as di;

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/",
  redirect: (context, state) async {
    if (state.fullPath == "/") {
      await Future.delayed(const Duration(seconds: 3));
      final bool isOnboardingVisited =
          CacheHelper.getData(key: AppKeys.isOnboardingVisited) ?? false;

      if (isOnboardingVisited) {
        await CachedData.initCalibrationData();
        return "/home";
      } else {
        return "/onboarding";
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: "/",
      name: AppRouteConstant.splashScreenRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: "/onboarding",
      name: AppRouteConstant.onboardingScreenRoute,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: "/permission",
      name: AppRouteConstant.permissionScreenRoute,
      builder: (context, state) => const PermissionScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider<CalibrationCubit>(
          create: (context) => di.init<CalibrationCubit>(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: "/userdata",
          name: AppRouteConstant.userDataScreenRoute,
          builder: (context, state) => const UserDataScreen(),
        ),
        GoRoute(
          path: "/calibration",
          name: AppRouteConstant.calibrationScreenRoute,
          builder: (context, state) => const CalibrationScreen(),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BlocProvider(
          create: (_) => di.init<StepCounterCubit>()..startStepsStream(),
          child: LayoutScreen(shell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/analytics',
              builder: (_, __) => const AnalyticsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              builder: (_, __) => const HistoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (_, __) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);



