import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_card.dart';

class InsightCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final InlineSpan content;

  const InsightCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return StrideCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24.sp),
          const VerticalSpacingWidget(value: 12),
          Text(
            title,
            style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: 18.sp,
                ),
          ),
          const VerticalSpacingWidget(value: 8),
          RichText(
            text: TextSpan(
              style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
              children: [content],
            ),
          ),
        ],
      ),
    );
  }
}



