import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hive/hive_service.dart';
import 'hive/notificationService/notification_service.dart';
import 'hive/notificationService/timezone_service.dart';
import 'res/routes/routes.dart';
import 'view_models/controller/localReminder/local_reminder_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();
  await NotificationService.init();
  await TimezoneService.init();
  Get.put(LocalReminderController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
    );
  }
}
