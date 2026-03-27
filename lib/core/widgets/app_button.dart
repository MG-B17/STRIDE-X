import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onNext, required this.text});
  final VoidCallback onNext;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              text,
              style: context.textTheme.labelLarge!.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color:context.colorScheme.surface,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(
              Icons.chevron_right_rounded,
              color: context.colorScheme.surface,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}
