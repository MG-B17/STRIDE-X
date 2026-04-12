import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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



