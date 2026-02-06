import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/res/fonts/app_fonts.dart';
import 'package:intl/intl.dart';

import '../../view_models/controller/reminderController/create_reminder_controller.dart';

class LocalReminderCreateScreen extends StatelessWidget {
  LocalReminderCreateScreen({super.key});

  final controller = Get.put(CreateReminderController());

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy • hh:mm a').format(dateTime);
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Create Reminder",
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER ICON
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple.shade400,
                          Colors.deepPurple.shade700,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_active_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// TITLE FIELD
                _buildSectionLabel("Title", Icons.title),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: controller.titleController,
                  hint: "Enter reminder title",
                  icon: Icons.edit_outlined,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Please enter a title" : null,
                ),

                const SizedBox(height: 25),

                /// DESCRIPTION FIELD
                _buildSectionLabel("Description", Icons.description_outlined),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: controller.descController,
                  hint: "What do you want to be reminded about?",
                  icon: Icons.notes_outlined,
                  maxLines: 4,
                  validator: (v) => v == null || v.isEmpty
                      ? "Please enter a description"
                      : null,
                ),

                const SizedBox(height: 35),

                /// DATE & TIME SECTION
                _buildSectionLabel("Schedule", Icons.schedule),
                const SizedBox(height: 15),

                Obx(() => _buildDateTimeCard(context, isDark)),

                const SizedBox(height: 40),
                _buildSectionLabel(
                  "Notification Timing",
                  Icons.notifications_active,
                ),
                const SizedBox(height: 12),

                Obx(() => _buildTimingDropdown()),
                const SizedBox(height: 30),

                /// SAVE BUTTON
                Obx(() => _buildSaveButton(context, isDark)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimingDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.notificationTiming.value,
          isExpanded: true,

          items: controller.timingOptions.map((item) {
            return DropdownMenuItem<String>(
              value: item["value"],
              child: Text(
                item["label"]!,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppFonts.opensansRegular,
                ),
              ),
            );
          }).toList(),

          onChanged: (value) {
            if (value != null) {
              controller.notificationTiming.value = value;
            }
          },
        ),
      ),
    );
  }

  /// SECTION LABEL
  Widget _buildSectionLabel(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }

  /// CUSTOM TEXT FIELD
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.deepPurple.shade300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.deepPurple.shade300, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  /// DATE & TIME CARD
  Widget _buildDateTimeCard(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade50,
            Colors.deepPurple.shade100.withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => controller.pickDateTime(context, true),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.deepPurple.shade700,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reminder Date & Time",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.startDate.value == null
                                ? "Tap to select"
                                : formatDateTime(controller.startDate.value!),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: controller.startDate.value == null
                                  ? Colors.grey[400]
                                  : Colors.deepPurple.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.deepPurple.shade400,
                      size: 18,
                    ),
                  ],
                ),

                /// SHOW DATE & TIME CHIPS IF SELECTED
                if (controller.startDate.value != null) ...[
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoChip(
                          icon: Icons.calendar_today_rounded,
                          label: "Date",
                          value: formatDate(controller.startDate.value!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoChip(
                          icon: Icons.access_time_rounded,
                          label: "Time",
                          value: formatTime(controller.startDate.value!),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// INFO CHIP
  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade100),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.deepPurple.shade400),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ],
      ),
    );
  }

  /// SAVE BUTTON
  Widget _buildSaveButton(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: controller.isLoading.value
              ? [Colors.grey.shade400, Colors.grey.shade500]
              : [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: controller.isLoading.value
            ? []
            : [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: controller.isLoading.value
              ? null
              : () async {
                  if (controller.startDate.value == null) {
                    Get.snackbar(
                      "Missing Information",
                      "Please select a reminder time",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.orange.shade100,
                      colorText: Colors.orange.shade900,
                      icon: const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                      ),
                      margin: const EdgeInsets.all(16),
                      borderRadius: 12,
                    );
                    return;
                  }
                  await controller.createReminder();
                },
          child: Center(
            child: controller.isLoading.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Create Reminder",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
