import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/res/color/app_colors.dart';
import 'package:getxmvvm/res/fonts/app_fonts.dart';
import 'package:getxmvvm/view/localReminder/local_reminder_create_screen.dart';
import 'package:intl/intl.dart';

import '../../view_models/controller/localReminder/local_reminder_controller.dart';

class LocalReminderListScreen extends StatelessWidget {
  LocalReminderListScreen({super.key});
  final controller = Get.find<LocalReminderController>();
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy • hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reminders")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => LocalReminderCreateScreen()),
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.reminders.length,
          itemBuilder: (_, i) {
            final r = controller.reminders[i];

            return ListTile(
              title: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    r.title,
                    style: TextStyle(
                      fontFamily: AppFonts.helveticaMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    r.description,
                    style: TextStyle(
                      fontFamily: AppFonts.opensansRegular,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),

              subtitle: Text(
                formatDateTime(r.dateTime),
                style: TextStyle(
                  fontFamily: AppFonts.opensansRegular,
                  color: AppColors.greyColor,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => controller.delete(r.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
