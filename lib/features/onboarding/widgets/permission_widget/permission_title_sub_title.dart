import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class PermissionTittleAndSubTittle extends StatelessWidget {
  const PermissionTittleAndSubTittle({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.w,
          height: 3.h,
          decoration: BoxDecoration(
            gradient: AppColors.actionGradient,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        VerticalSpacingWidget(value: 24),
        Text(
          AppStrings.permissionTitle,
          style:context. textTheme.headlineLarge?.copyWith(
            fontSize: 36.sp,
            height: 1.2,
          ),
        ),
        VerticalSpacingWidget(value: 16),
        Text(AppStrings.permissionSubtitle, style:context.textTheme.bodyMedium),
      ],
    );
  }
}



