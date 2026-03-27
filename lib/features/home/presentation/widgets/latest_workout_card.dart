import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/theme/text_styles.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class LatestWorkoutCard extends StatelessWidget {
  const LatestWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
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
                        AppStrings.viewMap,
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
                        AppStrings.latestWorkout,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: colorScheme.primary,
                        ),
                      ),
                      const VerticalSpacingWidget(value: 2),
                      Text(
                        AppStrings.defaultWorkout,
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
