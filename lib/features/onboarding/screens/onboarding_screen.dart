import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/utils/cache_helper.dart';
import 'package:stridex/core/widgets/app_button.dart';
import 'package:stridex/features/onboarding/models/onboarding_model.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/onboarding/widgets/onboarding_page_view.dart';
import 'package:stridex/features/onboarding/widgets/smooth_page_indecator_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.goNamed(AppRouteConstant.permissionScreenRoute);
      CacheHelper.saveData(key: AppKeys.isOnboardingVisited, value: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, index) => OnboardingPageView(page: pages[index]),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
            child: Column(
              children: [
                SmoothPageIndecatorWidget(
                  pageController: _pageController,
                  pageCount: pages.length,
                ),
                VerticalSpacingWidget(value: 24),
                AppButton(onNext: _onNext, text: AppStrings.next,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



