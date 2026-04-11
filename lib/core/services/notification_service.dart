import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:stridex/core/constant/app_strings.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _goalChannelId = 'goal_notifications';
  static const String _goalChannelName = 'Goal Achievements';
  static const String _goalChannelDescription =
      'Notifications for reaching your daily step goal';

  Future<void> init() async {
    // Initialize timezone data
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap if needed
      },
    );

    // Create Notification Channel for Android
    await _createNotificationChannel();
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _goalChannelId,
      _goalChannelName,
      description: _goalChannelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<bool> requestPermissions() async {
    final bool? androidGranted = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    final bool? iosGranted = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    return (androidGranted ?? false) || (iosGranted ?? false);
  }

  Future<void> showGoalReachedNotification({
    required int steps,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _goalChannelId,
      _goalChannelName,
      channelDescription: _goalChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      category: AndroidNotificationCategory.event,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notificationsPlugin.show(
      0,
      AppStrings.goalReachedTitle,
      AppStrings.goalReachedBody.replaceAll('{steps}', steps.toString()),
      notificationDetails,
    );
  }

  Future<void> showMotivationalReminder({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'motivational_reminders',
      'Motivational Reminders',
      channelDescription: 'Daily reminders to keep you active',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(
      1,
      title,
      body,
      notificationDetails,
    );
  }

  Future<void> scheduleDailyMorningMotivation() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'daily_motivation',
      'Daily Motivation',
      channelDescription: 'Morning reminders to start your day active',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.zonedSchedule(
      2,
      AppStrings.morningMotivationTitle,
      AppStrings.morningMotivationBody,
      _nextInstanceOfEightAM(),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfEightAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 8);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
