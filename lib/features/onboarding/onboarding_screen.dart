import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/theme/text_styles.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------
class _OnboardingPage {
  final String imagePath;
  final String title;
  final String titleHighlight;
  final String description;

  const _OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.titleHighlight,
    required this.description,
  });
}

const List<_OnboardingPage> _pages = [
  _OnboardingPage(
    imagePath: 'assets/images/Professional athlete running.png',
    title: 'Track Your',
    titleHighlight: 'Journey',
    description:
        'Real-time step tracking and deep insights to help you understand your movement patterns and hit your daily goals.',
  ),
  _OnboardingPage(
    imagePath: 'assets/images/Professional athlete running.png',
    title: 'Analyze Your',
    titleHighlight: 'Performance',
    description:
        'Dive deep into your metrics, compare sessions, and unlock the data you need to crush every personal record.',
  ),
  _OnboardingPage(
    imagePath: 'assets/images/Professional athlete running.png',
    title: 'Reach Your',
    titleHighlight: 'Goals',
    description:
        'Set targets, stay consistent, and celebrate every milestone on your path to peak athletic achievement.',
  ),
];

// ---------------------------------------------------------------------------
// Main screen
// ---------------------------------------------------------------------------
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
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.goNamed(AppRouteConstant.premissionScreenRoute);
    }
  }

  void _onSkip() {
    context.goNamed(AppRouteConstant.premissionScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface == AppColors.softSlate
          ? colorScheme.surface
          : colorScheme.surface,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, index) =>
                _OnboardingPageView(page: _pages[index]),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: _currentPage > 0
                          ? colorScheme.primary
                          : Colors.transparent,
                      size: 24.sp,
                    ),
                  ),
                  Text(
                    'STRIDEX',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                      letterSpacing: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: _onSkip,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom dots + button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomSection(
              pageController: _pageController,
              pageCount: _pages.length,
              onNext: _onNext,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Single page view
// ---------------------------------------------------------------------------
class _OnboardingPageView extends StatelessWidget {
  final _OnboardingPage page;
  const _OnboardingPageView({required this.page});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 53,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      page.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      filterQuality: FilterQuality.high,
                    ),
                    // Bottom fade into scaffold background
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0.0, 0.45, 1.0],
                            colors: [
                              scaffoldBg,
                              scaffoldBg.withValues(alpha: 0.55),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Top vignette
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.25],
                            colors: [
                              Colors.black.withValues(alpha: 0.45),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, bottom: 20.h),
                child: _PaceChip(),
              ),
            ],
          ),
        ),

        Expanded(
          flex: 47,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${page.title}\n',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 34.sp, height: 1.15),
                      ),
                      TextSpan(
                        text: page.titleHighlight,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                              fontSize: 34.sp,
                              height: 1.15,
                              color: colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  page.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Pace chip
// ---------------------------------------------------------------------------
class _PaceChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: scaffoldBg.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(Icons.speed_rounded, color: Colors.white, size: 16.sp),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PACE',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface.withValues(alpha: 0.55),
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                "4'20\"",
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom section
// ---------------------------------------------------------------------------
class _BottomSection extends StatelessWidget {
  final PageController pageController;
  final int pageCount;
  final VoidCallback onNext;

  const _BottomSection({
    required this.pageController,
    required this.pageCount,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 36.h),
      color: scaffoldBg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: pageController,
            count: pageCount,
            effect: ExpandingDotsEffect(
              activeDotColor: colorScheme.primary,
              dotColor: colorScheme.onSurface.withValues(alpha: 0.25),
              dotHeight: 6.h,
              dotWidth: 6.w,
              expansionFactor: 4,
              spacing: 5.w,
            ),
          ),
          SizedBox(height: 24.h),
          GestureDetector(
            onTap: onNext,
            child: Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                gradient: AppColors.actionGradient,
                borderRadius: BorderRadius.circular(32.r),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.onPrimary,
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
