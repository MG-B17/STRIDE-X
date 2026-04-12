import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    required this.unit,
  });

  final IconData icon;
  final String label;
  final TextEditingController controller;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StrideCard(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16.sp,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                HorizantilSpacingWidget(value: 8),
                Text(
                  label.toUpperCase(),
                  style: context.textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.2,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            VerticalSpacingWidget(value: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: context.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.primary,
                      fontSize: 42.sp,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                HorizantilSpacingWidget(value: 4),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    unit,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



