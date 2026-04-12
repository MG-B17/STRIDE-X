import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/di/injection.dart';
import 'package:stridex/core/services/notification_service.dart';
import 'package:stridex/core/utils/cache_helper.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/features/profile/presentation/widgets/notification_setting_item.dart';

import 'package:stridex/core/widgets/stride_card.dart';

class NotificationsCard extends StatefulWidget {
  const NotificationsCard({super.key});

  @override
  State<NotificationsCard> createState() => _NotificationsCardState();
}

class _NotificationsCardState extends State<NotificationsCard> {
  late bool dailyReminder;
  late bool streakAlerts;

  @override
  void initState() {
    super.initState();
    dailyReminder = CacheHelper.getData(key: AppKeys.isDailyReminderEnabled) ?? true;
    streakAlerts = CacheHelper.getData(key: AppKeys.isStreakAlertsEnabled) ?? true;
  }

  Future<void> _toggleDailyReminder(bool val) async {
    if (val) {
      final granted = await init<NotificationService>().requestPermissions();
      if (!granted) return;
      await init<NotificationService>().scheduleDailyMorningMotivation();
    } else {
      // Logic to cancel specific notification if needed
      // For simplicity, we'll just not show it in the service if toggle is off
    }
    
    setState(() => dailyReminder = val);
    CacheHelper.saveData(key: AppKeys.isDailyReminderEnabled, value: val);
  }

  Future<void> _toggleStreakAlerts(bool val) async {
    if (val) {
      final granted = await init<NotificationService>().requestPermissions();
      if (!granted) return;
    }
    
    setState(() => streakAlerts = val);
    CacheHelper.saveData(key: AppKeys.isStreakAlertsEnabled, value: val);
  }

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
            onChanged: _toggleDailyReminder,
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
            onChanged: _toggleStreakAlerts,
          ),
        ],
      ),
    );
  }
}



