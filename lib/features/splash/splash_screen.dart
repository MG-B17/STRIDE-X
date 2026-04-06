import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/core/utils/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isdark = false;
  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  void _nextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      final bool isOnboardingVisited =
          CacheHelper.getData(key: AppKeys.isOnboardingVisited) ?? false;

      if (isOnboardingVisited) {
        _loadData();
        context.goNamed(AppRouteConstant.layoutScreenRoute);
      } else {
        context.goNamed(AppRouteConstant.onboardingScreenRoute);
      }
    });
  }

  Future<void> _loadData() async {
    await CachedData.initCalibrationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Opacity(
            opacity: .19,
            child: SvgPicture.asset("assets/svg/Splash Screen.svg"),
          ),
          Center(child: SvgPicture.asset("assets/svg/splash_screen_icon.svg")),
        ],
      ),
    );
  }
}
