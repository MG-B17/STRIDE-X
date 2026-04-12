import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/theme/text_styles.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class PaceChip extends StatelessWidget {
  const PaceChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.25),
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
                colors: [context.colorScheme.primary, context.colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(Icons.speed_rounded, color: Colors.white, size: 16.sp),
          ),
          HorizantilSpacingWidget(value: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.pace,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.55),
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                AppStrings.defaultPace,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
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



