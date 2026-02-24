import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fcm/fcm_manager.dart';
import 'firebase_options.dart';
import 'hive/hive_service.dart';
import 'hive/notificationService/notification_service.dart';
import 'hive/notificationService/timezone_service.dart';
import 'res/routes/routes.dart';

///  MUST BE TOP LEVEL FUNCTION
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.notification != null) {
    log("BG Notification Title: ${message.notification!.title}");
  }

  if (message.data.isNotEmpty) {
    log("BG Data: ${message.data}");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // REGISTER BACKGROUND HANDLER
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  await FCMManager.init();

  await HiveService.init();
  await NotificationService.init();
  await TimezoneService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
    );
  }
}
