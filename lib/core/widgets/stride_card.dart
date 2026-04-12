import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/utils/extentions.dart';

class StrideCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const StrideCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: child,
    );
  }
}



