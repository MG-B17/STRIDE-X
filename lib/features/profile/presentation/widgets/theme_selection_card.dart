import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/features/profile/presentation/widgets/theme_card.dart';

class ThemeSelectionCard extends StatelessWidget {
  const ThemeSelectionCard({super.key});

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
          ThemeCard(icon:Icons.light_mode_outlined, label: AppStrings.lightTheme),
          ThemeCard(icon:Icons.dark_mode_outlined, label: AppStrings.darkTheme),
          ThemeCard(icon:Icons.settings_system_daydream_outlined, label: AppStrings.systemTheme),
        ],
      ),
    );
  }
}
