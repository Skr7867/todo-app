import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../hive/notificationService/notification_service.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final args = Get.arguments ?? {};
  StreamSubscription? shakeSub;
  Timer? repeatTimer;

  @override
  void initState() {
    super.initState();

    final id = args["id"];

    startShake(id);
    startRepeat(id);
  }

  void startShake(int id) {
    shakeSub = accelerometerEvents.listen((event) {
      double total = event.x.abs() + event.y.abs() + event.z.abs();
      if (total > 35) dismiss(id);
    });
  }

  void startRepeat(int id) {
    repeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      NotificationService.schedule(
        id: id,
        title: args["title"],
        body: args["body"],
        dateTime: DateTime.now().add(const Duration(seconds: 2)),
      );
    });
  }

  Future dismiss(int id) async {
    await NotificationService.cancel(id);
    shakeSub?.cancel();
    repeatTimer?.cancel();
    Get.back();
  }

  @override
  void dispose() {
    shakeSub?.cancel();
    repeatTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int id = args["id"];
    final title = args["title"];
    final body = args["body"];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                body,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),

              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () => NotificationService.snoozeMinutes(id, 5),
                child: const Text("Snooze 5 min"),
              ),

              ElevatedButton(
                onPressed: () => NotificationService.snoozeMinutes(id, 10),
                child: const Text("Snooze 10 min"),
              ),

              ElevatedButton(
                onPressed: () => dismiss(id),
                child: const Text("Dismiss"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
