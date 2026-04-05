import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/features/Calibration/presentation/screens/calibration_screen.dart';
import 'package:stridex/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/calibration/presentation/screens/user_data_screen.dart';
import 'package:stridex/features/history/presentation/screens/history_screen.dart';
import 'package:stridex/features/step_counter/presentation/screens/home_screen.dart';
import 'package:stridex/features/layout/presentation/screens/layout_screen.dart';
import 'package:stridex/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:stridex/features/onboarding/presentation/screens/premission_screen.dart';
import 'package:stridex/features/profile/presentation/screens/profile_screen.dart';
import 'package:stridex/features/splash/splash_screen.dart';
import 'package:stridex/core/di/injection.dart'as di;

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
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
      path: "/premission",
      name: AppRouteConstant.premissionScreenRoute,
      builder: (context, state) => const PremissionScreen(),
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
    GoRoute(
      path: "/layout",
      name: AppRouteConstant.layoutScreenRoute,
      builder: (context, state) => const LayoutScreen(),
      routes: [
        GoRoute(
          path: "home",
          name: AppRouteConstant.homeScreenRoute,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: "analytic",
          name: AppRouteConstant.analyticScreenRoute,
          builder: (context, state) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: "history",
          name: AppRouteConstant.historyScreenRoute,
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: "profile",
          name: AppRouteConstant.profileScreenRoute,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
