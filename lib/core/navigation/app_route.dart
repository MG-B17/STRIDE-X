import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/features/analytics_dashboard/analytics_screen.dart';
import 'package:stridex/features/home/home_screen.dart';
import 'package:stridex/features/layout/layout.dart';
import 'package:stridex/features/onboarding/onboarding_screen.dart';
import 'package:stridex/features/onboarding/premission_screen.dart';
import 'package:stridex/features/profile/profile_screen.dart';
import 'package:stridex/features/splash/splash_screen.dart';
import 'package:stridex/features/streak/streak_screen.dart';

final GoRouter appRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: AppRouteConstant.splashScreenRoute,
        builder: (context, state) =>const SplashScreen(),
      ),
      GoRoute(
        path: "/onboarding",
        name: AppRouteConstant.onboardingScreenRoute,
        builder: (context, state) =>const OnboardingScreen(),
      ),
      GoRoute(
        path: "/premission",
        name: AppRouteConstant.premissionScreenRoute,
        builder: (context, state) =>const PremissionScreen(),
      ),
      GoRoute(
        path: "/layout",
        name: AppRouteConstant.layoutScreenRoute,
        builder: (context, state) =>const Layout(),
      ),
      GoRoute(
        path: "/home",
        name: AppRouteConstant.homeScreenRoute,
        builder: (context, state) =>const HomeScreen(),
      ),
      GoRoute(
        path: "/analytic",
        name: AppRouteConstant.analyticScreenRoute,
        builder: (context, state) =>const AnalyticsScreen(),
      ),
      GoRoute(
        path: "/streak",
        name: AppRouteConstant.streakScreenRoute,
        builder: (context, state) =>const StreakScreen(),
      ),
      GoRoute(
        path: "/profile",
        name: AppRouteConstant.profileScreenRoute,
        builder: (context, state) =>const ProfileScreen(),
      ),
    ],
  );
