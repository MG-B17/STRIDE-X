import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class ThemeSelectionCard extends StatefulWidget {
  const ThemeSelectionCard({super.key});

  @override
  State<ThemeSelectionCard> createState() => _ThemeSelectionCardState();
}

class _ThemeSelectionCardState extends State<ThemeSelectionCard> {
  String selectedTheme = AppStrings.darkTheme; // Mock default

  Widget _buildThemeOption(IconData icon, String label) {
    final isSelected = selectedTheme == label;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTheme = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected 
                ? (isDark ? AppColors.surfaceGreen.withValues(alpha: 0.5) : context.colorScheme.primary.withValues(alpha: 0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? context.colorScheme.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface.withValues(alpha: 0.5),
                size: 24.sp,
              ),
              VerticalSpacingWidget(value: 8),
              Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: isSelected ? context.colorScheme.primary : context.colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceGreen : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.borderStrokeDark : AppColors.borderStrokeLight,
        ),
      ),
      child: Row(
        children: [
          _buildThemeOption(Icons.light_mode_outlined, AppStrings.lightTheme),
          _buildThemeOption(Icons.dark_mode_outlined, AppStrings.darkTheme),
          _buildThemeOption(Icons.settings_system_daydream_outlined, AppStrings.systemTheme),
        ],
      ),
    );
  }
}
