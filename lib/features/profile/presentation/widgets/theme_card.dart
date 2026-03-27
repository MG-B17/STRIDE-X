import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/theme/theme_controller.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Consumer<ThemeProvider>(
      builder: (context,themeProvider,_)=>Expanded(
        child: GestureDetector(
          onTap: () {
            themeProvider.selectTheme(mode: label);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: themeProvider.selectedTheme ==label
                  ? (isDark
                        ? AppColors.surfaceGreen.withValues(alpha: 0.5)
                        : context.colorScheme.primary.withValues(alpha: 0.1))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: themeProvider.selectedTheme ==label
                    ? context.colorScheme.primary
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: themeProvider.selectedTheme ==label
                      ? context.colorScheme.primary
                      : context.colorScheme.onSurface.withValues(alpha: 0.5),
                  size: 24.sp,
                ),
                const VerticalSpacingWidget(value: 8),
                Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    color:themeProvider.selectedTheme ==label
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight:themeProvider.selectedTheme ==label ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


