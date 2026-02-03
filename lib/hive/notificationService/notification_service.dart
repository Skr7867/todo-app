import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../res/routes/routes_name.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// ✅ INIT
  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        try {
          if (response.payload != null) {
            final data = jsonDecode(response.payload!);

            Get.toNamed(RouteName.alarmScreen, arguments: data);
          }
        } catch (e) {
          log("Payload error $e");
        }
      },
    );

    /// ⭐ CREATE ALARM CHANNEL MANUALLY
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'reminder_channel',
      'Reminders',
      description: 'Reminder Alarm Notifications',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(channel);

    /// ⭐ REQUEST PERMISSION
    await androidPlugin?.requestNotificationsPermission();
  }

  /// 🔔 SCHEDULE
  static Future schedule({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    try {
      if (dateTime.isBefore(DateTime.now())) {
        log("❌ Cannot schedule past time");
        return;
      }

      /// ✅ CREATE PAYLOAD
      final payload = jsonEncode({"id": id, "title": title, "body": body});

      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(dateTime, tz.local),

        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminders',
            channelDescription: 'Reminder Notifications',

            importance: Importance.max,
            priority: Priority.max,

            fullScreenIntent: true,
            category: AndroidNotificationCategory.alarm,

            playSound: true,
            enableVibration: true,
            ongoing: true,
            autoCancel: false,
          ),
        ),

        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

        /// ✅ PASS PAYLOAD HERE
        payload: payload,
      );

      log("✅ Notification Scheduled $id");
    } catch (e) {
      log("❌ Notification Schedule Error => $e");
    }
  }

  /// 😴 SNOOZE
  static Future snooze(int id, Duration delay) async {
    final newTime = DateTime.now().add(delay);

    await schedule(
      id: id,
      title: "Snoozed Reminder",
      body: "Reminder after snooze",
      dateTime: newTime,
    );
  }

  /// ❌ CANCEL
  static Future cancel(int id) async {
    await _plugin.cancel(id: id);
  }
}
