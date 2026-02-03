import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/reminder/local_reminders_model.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/localReminder/local_reminder_controller.dart';

class LocalReminderCreateScreen extends StatelessWidget {
  LocalReminderCreateScreen({super.key});

  final controller = Get.find<LocalReminderController>();

  final title = TextEditingController();
  final desc = TextEditingController();

  /// ✅ MAKE REACTIVE DATE
  final Rx<DateTime> selected = DateTime.now()
      .add(const Duration(minutes: 1))
      .obs;

  /// ✅ DATE PICKER
  Future pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: selected.value,
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selected.value),
    );

    if (time == null) return;

    selected.value = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy • hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Reminder")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// TITLE
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            /// DESCRIPTION
            TextField(
              controller: desc,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 20),

            /// ✅ DATE DISPLAY + PICKER
            Obx(
              () => ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Reminder Time"),
                subtitle: Text(formatDateTime(selected.value)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => pickDateTime(context),
              ),
            ),

            const SizedBox(height: 20),

            /// SAVE BUTTON
            ElevatedButton(
              onPressed: () async {
                if (title.text.isEmpty) {
                  Get.snackbar("Error", "Enter title");
                  return;
                }

                if (selected.value.isBefore(DateTime.now())) {
                  Get.snackbar("Error", "Select future time");
                  return;
                }

                await controller.create(
                  ReminderModel(
                    id: DateTime.now().microsecondsSinceEpoch % 4294967295,
                    title: title.text,
                    description: desc.text,
                    dateTime: selected.value,
                  ),
                );

                Get.snackbar("Success", "Reminder Saved");

                await Future.delayed(const Duration(milliseconds: 300));

                Get.offNamed(RouteName.localReminderListScreen);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
