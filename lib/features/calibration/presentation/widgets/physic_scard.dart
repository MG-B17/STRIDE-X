import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/stride_card.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class PhysicSCard extends StatefulWidget {
  const PhysicSCard({super.key});

  @override
  State<PhysicSCard> createState() => _PhysicSCardState();
}

class _PhysicSCardState extends State<PhysicSCard> {
  final TextEditingController _heightController = TextEditingController(text: '180');
  final TextEditingController _weightController = TextEditingController(text: '75');

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String unit,
  }) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

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
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                HorizantilSpacingWidget(value: 8),
                Text(
                  label.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.2,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
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
                    style: textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
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
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildInfoCard(
          icon: Icons.straighten_rounded,
          label: AppStrings.height,
          controller: _heightController,
          unit: AppStrings.cm,
        ),
        HorizantilSpacingWidget(value: 12),
        _buildInfoCard(
          icon: Icons.monitor_weight_rounded,
          label: AppStrings.weight,
          controller: _weightController,
          unit: AppStrings.kg,
        ),
      ],
    );
  }
}
