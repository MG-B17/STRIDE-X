import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/features/profile/presentation/widgets/notification_setting_item.dart';

class NotificationsCard extends StatefulWidget {
  const NotificationsCard({super.key});

  @override
  State<NotificationsCard> createState() => _NotificationsCardState();
}

class _NotificationsCardState extends State<NotificationsCard> {
  bool dailyReminder = true;
  bool streakAlerts = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceGreen : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? AppColors.borderStrokeDark : AppColors.borderStrokeLight,
        ),
      ),
      child: Column(
        children: [
          NotificationSettingItem(
            title: AppStrings.dailyReminder,
            description: AppStrings.dailyReminderDesc,
            value: dailyReminder,
            onChanged: (val) {
              setState(() => dailyReminder = val);
            },
          ),
          Divider(
            color: context.colorScheme.onSurface.withValues(alpha: 0.1),
            height: 1,
            thickness: 1,
          ),
          NotificationSettingItem(
            title: AppStrings.streakAlerts,
            description: AppStrings.streakAlertsDesc,
            value: streakAlerts,
            onChanged: (val) {
              setState(() => streakAlerts = val);
            },
          ),
        ],
      ),
    );
  }
}
