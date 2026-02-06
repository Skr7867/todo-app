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

      onDidReceiveNotificationResponse: (response) async {
        try {
          if (response.payload == null) return;

          final data = jsonDecode(response.payload!);
          final int id = data["id"];

          /// ⭐ CHECK WHICH BUTTON PRESSED
          if (response.actionId == "STOP_ACTION") {
            await cancel(id);

            return;
          }

          if (response.actionId == "SNOOZE_ACTION") {
            await snoozeMinutes(id, 5);

            return;
          }

          /// NORMAL NOTIFICATION CLICK
          Get.toNamed(RouteName.alarmScreen, arguments: data);
        } catch (e) {
          log("Action error $e");
        }
      },
    );

    /// ⭐ HANDLE APP OPEN FROM KILLED STATE
    final details = await _plugin.getNotificationAppLaunchDetails();

    if (details?.didNotificationLaunchApp ?? false) {
      final payload = details!.notificationResponse?.payload;

      if (payload != null) {
        final data = jsonDecode(payload);

        /// Delay ensures GetX navigation works after app init
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAllNamed(RouteName.alarmScreen, arguments: data);
        });
      }
    }

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

            /// ⭐ ACTION BUTTONS HERE
            actions: <AndroidNotificationAction>[
              AndroidNotificationAction(
                'STOP_ACTION',
                'Stop',
                showsUserInterface: true,
                cancelNotification: true,
              ),

              AndroidNotificationAction(
                'SNOOZE_ACTION',
                'Snooze',
                showsUserInterface: false,
              ),
            ],
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
  static Future snoozeMinutes(int id, int minutes) async {
    final newTime = DateTime.now().add(Duration(minutes: minutes));

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
