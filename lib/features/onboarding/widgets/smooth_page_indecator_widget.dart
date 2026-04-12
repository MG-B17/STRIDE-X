import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stridex/core/utils/extentions.dart';

class SmoothPageIndecatorWidget extends StatelessWidget {
  const SmoothPageIndecatorWidget({super.key,required this.pageController,required this.pageCount});
  final PageController pageController;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: pageCount,
      effect: ExpandingDotsEffect(
        activeDotColor: context.colorScheme.primary,
        dotColor: context.colorScheme.onSurface.withValues(alpha: 0.25),
        dotHeight: 6.h,
        dotWidth: 6.w,
        expansionFactor: 4,
        spacing: 5.w,
      ),
    );
  }
}



