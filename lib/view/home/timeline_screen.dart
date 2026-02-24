import 'package:everem/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../view_models/controller/deleteReminder/delete_reminder_controller.dart';
import '../../view_models/controller/logOut/log_out_controller.dart';
import '../../view_models/controller/reminderDetails/reminder_details_controller.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final LogOutController controller = Get.put(LogOutController());
  final ReminderDetailsController reminderDetailsController = Get.put(
    ReminderDetailsController(),
  );

  final Map<String, bool> _switchStates = {};

  void _showDeleteDialog(
    BuildContext context,
    String? reminderId,
    String? title,
  ) {
    final deleteController = Get.put(DeleteReminderController());

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color.fromARGB(255, 61, 122, 101),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade400,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Delete Reminder?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Are you sure you want to delete "${title ?? 'this reminder'}"?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: deleteController.isDeleting.value
                            ? null
                            : () {
                                Navigator.pop(context);

                                if (reminderId != null) {
                                  deleteController.deleteReminder(reminderId);
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Reminder ID not found",
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: deleteController.isDeleting.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Delete"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B2A1F),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Get.toNamed(RouteName.localReminderCreateScreen);
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F3A28), Color(0xFF081C15)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                /// ================= HEADER =================
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Timeline",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Your Reminders",
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteName.notificationScreen);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.notifications_active_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF163D2B),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.login_rounded,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                /// ================= SEARCH BAR =================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF163D2B),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.white54),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.green,
                          controller:
                              reminderDetailsController.searchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Search events...",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            reminderDetailsController.searchQuery.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// ================= COMING UP NEXT =================
                const Text(
                  "COMING UP NEXT",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 15),

                _buildComingUpCard(),

                const SizedBox(height: 30),

                /// ================= THIS WEEK =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ALL REMINDERS",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${reminderDetailsController.remindersList.length} EVENTS",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                /// ================= REMINDERS LIST =================
                Obx(() {
                  if (reminderDetailsController.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: Colors.greenAccent,
                        ),
                      ),
                    );
                  }

                  final list = reminderDetailsController.filteredReminders;

                  if (list.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          "No matching reminders",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: list.map((r) {
                      DateTime? date;

                      if (r.eventStartDate != null) {
                        date = DateTime.parse(r.eventStartDate!).toLocal();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Dismissible(
                          key: Key(r.id ?? DateTime.now().toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          confirmDismiss: (_) async {
                            _showDeleteDialog(context, r.id, r.title);
                            return false;
                          },
                          child: _buildEventTile(
                            icon: Icons.notifications_active,
                            iconColor: Colors.greenAccent,
                            title: r.title ?? "Reminder",
                            subtitle: date != null
                                ? DateFormat(
                                    "MMM dd, yyyy • hh:mm a",
                                  ).format(date)
                                : "No Date",
                            value: _switchStates[r.id ?? ""] ?? true,
                            onChanged: (v) {
                              setState(() {
                                _switchStates[r.id ?? ""] = v;
                              });
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= COMING UP CARD =================
  Widget _buildComingUpCard() {
    return Obx(() {
      final reminders = reminderDetailsController.remindersList;

      if (reminders.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF1E6F4C), Color(0xFF124734)],
            ),
          ),
          child: const Text(
            "Your upcoming reminders will appear here",
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      final now = DateTime.now();

      /// ✅ FILTER ONLY FUTURE REMINDERS
      final upcoming = reminders.where((r) {
        if (r.eventStartDate == null) return false;
        final date = DateTime.parse(r.eventStartDate!).toLocal();
        return date.isAfter(now); // 🔥 only future
      }).toList();

      if (upcoming.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF1E6F4C), Color(0xFF124734)],
            ),
          ),
          child: const Text(
            "No upcoming reminders",
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      /// ✅ SORT BY NEAREST DATE
      upcoming.sort((a, b) {
        final aDate = DateTime.parse(a.eventStartDate!).toLocal();
        final bDate = DateTime.parse(b.eventStartDate!).toLocal();
        return aDate.compareTo(bDate);
      });

      final latest = upcoming.first; // 🔥 nearest upcoming

      final eventDate = DateTime.parse(latest.eventStartDate!).toLocal();

      final difference = eventDate.difference(now);

      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF1E6F4C), Color(0xFF124734)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "REMINDER",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.notifications_active,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// TITLE
            Text(
              latest.title ?? "Reminder",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 4),

            /// DATE
            Text(
              DateFormat("MMMM dd, yyyy").format(eventDate),
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 20),

            /// COUNTDOWN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _countBox(days.toString().padLeft(2, '0'), "DAYS"),
                _countBox(hours.toString().padLeft(2, '0'), "HOURS"),
                _countBox(minutes.toString().padLeft(2, '0'), "MINS"),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _countBox(String number, String label) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF163D2B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  /// ================= EVENT TILE =================
  Widget _buildEventTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF163D2B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: Colors.greenAccent,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  /// ================= LOGOUT DIALOG =================
  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: const Color.fromARGB(255, 56, 116, 95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout, color: Colors.red, size: 40),
              const SizedBox(height: 20),
              const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: ButtonStyle(),

                      onPressed: () => Get.back(),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                        controller.logout();
                      },
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
