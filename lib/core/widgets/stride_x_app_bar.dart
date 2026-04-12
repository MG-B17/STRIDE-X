import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/text_styles.dart';
import 'package:stridex/core/utils/extentions.dart';

class StrideXAppBar extends StatelessWidget {
  const StrideXAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.appName,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: context.colorScheme.primary,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}



