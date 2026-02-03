import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmScreen extends StatelessWidget {
  AlarmScreen({super.key});

  final args = Get.arguments ?? {};

  @override
  Widget build(BuildContext context) {
    final String title = args["title"] ?? "Reminder";
    final String body = args["body"] ?? "Reminder Alert";

    return Scaffold(
      backgroundColor: Colors.red.shade400,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              body,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),

            const SizedBox(height: 60),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Snooze logic
                  },
                  child: const Text("Snooze"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Dismiss"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
