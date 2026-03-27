import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/features/profile/presentation/widgets/notification_setting_item.dart';

import 'package:stridex/core/widgets/stride_card.dart';

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
    return StrideCard(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
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
