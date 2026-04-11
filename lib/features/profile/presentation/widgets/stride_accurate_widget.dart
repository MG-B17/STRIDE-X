import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/constant/route_constant.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class StrideAccurateWidget extends StatelessWidget {
  const StrideAccurateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRouteConstant.calibrationScreenRoute);
      },
      child: StrideCard(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.tune_rounded, 
                  color: context.colorScheme.primary, 
                  size: 24.sp,
                ),
              ),
              HorizantilSpacingWidget(value: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.recalibrateTracker,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    VerticalSpacingWidget(value: 4),
                    Text(
                      AppStrings.recalibrateTrackerDesc,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              HorizantilSpacingWidget(value: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: context.colorScheme.onSurfaceVariant,
                size: 24.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
