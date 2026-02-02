import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../view_models/controller/reminderDetails/reminder_details_controller.dart';

class ReminderDetailsScreen extends StatelessWidget {
  ReminderDetailsScreen({super.key});

  final controller = Get.put(ReminderDetailsController());

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "-";
    return DateFormat('dd MMM yyyy • hh:mm a').format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reminder Details")),

      body: Obx(() {
        /// LOADING
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ERROR
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final reminders =
            controller.reminderResponse.value?.data?.reminders ?? [];

        /// EMPTY
        if (reminders.isEmpty) {
          return const Center(child: Text("No Reminders Found"));
        }

        /// LIST UI
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: reminders.length,
          itemBuilder: (_, index) {
            final r = reminders[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      r.title ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// DESCRIPTION
                    Text(r.description ?? ""),

                    const SizedBox(height: 16),

                    /// REMINDER DATE
                    Row(
                      children: [
                        const Icon(Icons.alarm),
                        const SizedBox(width: 8),
                        Text(formatDate(r.reminderDate)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// EVENT SECTION
                    if (r.isEvent == true) ...[
                      Text("Event Type: ${r.eventType ?? "-"}"),

                      Text("Start: ${formatDate(r.eventStartDate)}"),

                      Text("End: ${formatDate(r.eventEndDate)}"),

                      Text("Location: ${r.location ?? "-"}"),

                      Text(r.allDay == true ? "All Day Event" : "Timed Event"),

                      const SizedBox(height: 16),
                    ],

                    /// CATEGORY
                    Text("Category: ${r.category ?? "-"}"),

                    const SizedBox(height: 8),

                    /// NOTIFICATION
                    Text("Notification: ${r.notificationTiming ?? "-"}"),

                    const SizedBox(height: 16),

                    /// ATTENDEES
                    if (r.attendees.isNotEmpty) ...[
                      const Text(
                        "Attendees",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 8),

                      ...r.attendees.map((a) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(a.name ?? ""),
                          subtitle: Text("${a.email ?? ""} | ${a.phone ?? ""}"),
                          trailing: Chip(label: Text(a.status ?? "")),
                        );
                      }).toList(),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
