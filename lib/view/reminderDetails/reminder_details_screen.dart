import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../view_models/controller/deleteReminder/delete_reminder_controller.dart';
import '../../view_models/controller/reminderDetails/reminder_details_controller.dart';

class ReminderDetailsScreen extends StatelessWidget {
  ReminderDetailsScreen({super.key});

  final controller = Get.put(ReminderDetailsController());

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "-";
    final dt = DateTime.parse(date).toLocal();
    return DateFormat('dd MMM yyyy • hh:mm a').format(dt);
  }

  String formatTime(String? date) {
    if (date == null || date.isEmpty) return "-";
    final dt = DateTime.parse(date).toLocal();
    return DateFormat('hh:mm a').format(dt);
  }

  Color _getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'work':
        return Colors.blue;
      case 'personal':
        return Colors.purple;
      case 'health':
        return Colors.green;
      case 'family':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'work':
        return Icons.work_outline;
      case 'personal':
        return Icons.person_outline;
      case 'health':
        return Icons.favorite_outline;
      case 'family':
        return Icons.family_restroom;
      default:
        return Icons.label_outline;
    }
  }

  void _showDeleteDialog(
    BuildContext context,
    String? reminderId,
    String? title,
  ) {
    final deleteController = Get.put(DeleteReminderController());

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Are you sure you want to delete "${title ?? 'this reminder'}"?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
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
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          "My Reminders",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: Obx(() {
        /// LOADING
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading reminders...',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                ),
              ],
            ),
          );
        }

        /// ERROR
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          );
        }

        final reminders =
            controller.reminderResponse.value?.data?.reminders ?? [];

        /// EMPTY STATE
        if (reminders.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_none,
                      size: 80,
                      color: Colors.blue.shade300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'No Reminders Yet',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your reminders will appear here',
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          );
        }

        /// REMINDER LIST
        return ListView.builder(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          itemCount: reminders.length,
          itemBuilder: (_, index) {
            final r = reminders[index];
            final categoryColor = _getCategoryColor(r.category);

            return Dismissible(
              key: Key('reminder_$index'),
              direction: DismissDirection.endToStart,
              background: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 28,
                ),
              ),
              confirmDismiss: (direction) async {
                _showDeleteDialog(context, r.id, r.title);

                return false;
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .25),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    /// CATEGORY COLOR ACCENT
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 5,
                        decoration: BoxDecoration(
                          // color: categoryColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// HEADER ROW
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// CATEGORY ICON
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: categoryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  _getCategoryIcon(r.category),
                                  color: categoryColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),

                              /// TITLE & CATEGORY
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      r.title ?? "Untitled",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: categoryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        r.category ?? "General",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: categoryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// DELETE BUTTON
                              IconButton(
                                onPressed: () =>
                                    _showDeleteDialog(context, r.id, r.title),

                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.grey.shade50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          if (r.description != null &&
                              r.description!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              r.description!,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                                height: 1.5,
                              ),
                            ),
                          ],

                          const SizedBox(height: 20),

                          /// REMINDER DATE/TIME
                          _InfoRow(
                            icon: Icons.access_time,
                            label: 'Reminder',
                            value: formatDate(r.reminderDate),
                            color: Colors.blue,
                          ),

                          /// NOTIFICATION
                        ],
                      ),
                    ),
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

/// REUSABLE INFO ROW WIDGET
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
