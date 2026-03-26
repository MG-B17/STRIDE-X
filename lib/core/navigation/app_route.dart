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

GoRouter appRouter() {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: AppRouteConstant.splashScreenRoute,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: "/onboarding",
        name: AppRouteConstant.onboardingScreenRoute,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: "/premission",
        name: AppRouteConstant.premissionScreenRoute,
        builder: (context, state) => PremissionScreen(),
      ),
      GoRoute(
        path: "/layout",
        name: AppRouteConstant.layoutScreenRoute,
        builder: (context, state) => Layout(),
      ),
      GoRoute(
        path: "/home",
        name: AppRouteConstant.homeScreenRoute,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: "/analytic",
        name: AppRouteConstant.analyticScreenRoute,
        builder: (context, state) => AnalyticsScreen(),
      ),
      GoRoute(
        path: "/streak",
        name: AppRouteConstant.streakScreenRoute,
        builder: (context, state) => StreakScreen(),
      ),
      GoRoute(
        path: "/profile",
        name: AppRouteConstant.profileScreenRoute,
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );
}
