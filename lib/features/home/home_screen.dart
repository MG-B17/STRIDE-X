import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/theme/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(),
              SizedBox(height: 28.h),
              _StepRing(steps: 7542, goal: 10000),
              SizedBox(height: 16.h),
              _MotivationalText(),
              SizedBox(height: 28.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        iconPath: 'assets/svg/cal_icon.svg',
                        value: '342',
                        label: 'KCAL BURNED',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _StatCard(
                        iconPath: 'assets/svg/km_icon.svg',
                        value: '5.2',
                        label: 'KM DISTANCE',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _ActiveTimeCard(iconPath: 'assets/svg/timer_icon.svg'),
              ),
              SizedBox(height: 28.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _WeeklyProgress(
                  values: [0.55, 0.40, 0.70, 1.0, 0.60, 0.30, 0.45],
                  activeIndex: 3,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _WorkoutCard(),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top Bar
// ---------------------------------------------------------------------------
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.menu_rounded,
                color: colorScheme.primary, size: 26.sp),
          ),
          Text(
            'StrideX',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: colorScheme.primary,
              letterSpacing: 0.5,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/svg/setting.svg',
              width: 26.w,
              height: 26.w,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Motivational text
// ---------------------------------------------------------------------------
class _MotivationalText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bodyStyle = Theme.of(context).textTheme.bodyLarge;
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: bodyStyle,
          children: [
            const TextSpan(text: "You're crushing it! "),
            TextSpan(
              text: 'Only 2,458\nsteps',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),
            const TextSpan(text: ' to your goal.'),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Circular Step Progress Ring
// ---------------------------------------------------------------------------
class _StepRing extends StatelessWidget {
  final int steps;
  final int goal;
  const _StepRing({required this.steps, required this.goal});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double progress = (steps / goal).clamp(0.0, 1.0);
    final int percent = (progress * 100).round();

    return Center(
      child: SizedBox(
        width: 200.w,
        height: 200.w,
        child: CustomPaint(
          painter: _RingPainter(progress: progress),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _fmt(steps),
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 38.sp,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'STEPS',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  gradient: AppColors.actionGradient,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '$percent% COMPLETE',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(int n) {
    final s = n.toString();
    return n >= 1000
        ? '${s.substring(0, s.length - 3)},${s.substring(s.length - 3)}'
        : s;
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.surfaceGreen
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..shader = AppColors.actionGradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}

// ---------------------------------------------------------------------------
// Stat Card
// ---------------------------------------------------------------------------
class _StatCard extends StatelessWidget {
  final String iconPath;
  final String value;
  final String label;

  const _StatCard({
    required this.iconPath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceGreen : colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? AppColors.borderStrokeDark
              : AppColors.borderStrokeLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 22.w,
            height: 22.w,
            colorFilter: ColorFilter.mode(
              colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
              height: 1.0,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: colorScheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Active Time Card
// ---------------------------------------------------------------------------
class _ActiveTimeCard extends StatelessWidget {
  final String iconPath;
  const _ActiveTimeCard({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceGreen : colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? AppColors.borderStrokeDark
              : AppColors.borderStrokeLight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACTIVE TIME',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '1h 12m',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  height: 1.1,
                ),
              ),
            ],
          ),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.12),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 20.w,
                height: 20.w,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Weekly Progress
// ---------------------------------------------------------------------------
class _WeeklyProgress extends StatelessWidget {
  final List<double> values;
  final int activeIndex;

  const _WeeklyProgress({required this.values, required this.activeIndex});

  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly Progress', style: textTheme.headlineSmall),
                SizedBox(height: 2.h),
                Text(
                  'Last 7 days performance',
                  style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
            Icon(Icons.trending_up_rounded,
                color: colorScheme.primary, size: 22.sp),
          ],
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 100.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(values.length, (i) {
              final isActive = i == activeIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          heightFactor: values[i].clamp(0.08, 1.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutCubic,
                            decoration: BoxDecoration(
                              gradient: isActive
                                  ? AppColors.actionGradient
                                  : LinearGradient(
                                      colors: isDark
                                          ? [
                                              const Color(0xFF1A4D2E),
                                              const Color(0xFF0D2918)
                                            ]
                                          : [
                                              AppColors.kineticGreen
                                                  .withValues(alpha: 0.18),
                                              AppColors.kineticGreen
                                                  .withValues(alpha: 0.08),
                                            ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        _days[i],
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 11.sp,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isActive
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Latest Workout Card
// ---------------------------------------------------------------------------
class _WorkoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        height: 150.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/Main Illustration.png',
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        'View Map',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LATEST WORKOUT',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Evening Park Loop',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}