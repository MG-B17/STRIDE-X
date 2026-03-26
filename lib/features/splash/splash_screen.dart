import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/route_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isdark = false ;
  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  void _nextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.goNamed(AppRouteConstant.onboardingScreenRoute);
    });
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
