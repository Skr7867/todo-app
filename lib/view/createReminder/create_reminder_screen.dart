import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_models/controller/reminderController/create_reminder_controller.dart';

class CreateReminderScreen extends StatelessWidget {
  CreateReminderScreen({super.key});

  final controller = Get.put(CreateReminderController());

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (v) {
          if (v == null || v.isEmpty) return "Required";

          if (label == "Email") {
            if (!GetUtils.isEmail(v)) return "Enter valid email";
          }

          if (label == "Phone") {
            if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
              return "Enter valid 10 digit phone";
            }
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, size: 20) : null,
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(Get.context!).primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(Get.context!).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: Theme.of(Get.context!).primaryColor,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSwitch(String title, RxBool value, {IconData? icon}) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SwitchListTile(
          title: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: Colors.grey[700]),
                const SizedBox(width: 12),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          value: value.value,
          onChanged: (v) => value.value = v,
          activeColor: Theme.of(Get.context!).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    TextEditingController controller, {
    IconData? icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: DropdownButtonFormField<String>(
        hint: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: Colors.grey[600]),
              const SizedBox(width: 12),
            ],
            Text(hint),
          ],
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        borderRadius: BorderRadius.circular(16),
        dropdownColor: Colors.white,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) => controller.text = v ?? "",
      ),
    );
  }

  Widget _buildDateSelector(
    String label,
    Rx<DateTime?> date,
    VoidCallback onTap,
  ) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.calendar_today,
              size: 20,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
          title: Text(
            date.value == null ? label : date.value.toString().split('.')[0],
            style: TextStyle(
              fontSize: 15,
              color: date.value == null ? Colors.grey[600] : Colors.black87,
              fontWeight: date.value == null
                  ? FontWeight.normal
                  : FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[400],
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildMethodInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.methodController,
                  decoration: InputDecoration(
                    hintText: "Add notification method",
                    prefixIcon: const Icon(
                      Icons.notifications_outlined,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: controller.addMethod,
                ),
              ),
            ],
          ),
          Obx(
            () => controller.notificationMethods.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.notificationMethods.map((e) {
                        return Chip(
                          label: Text(e),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () => controller.removeMethod(e),
                          backgroundColor: Theme.of(
                            Get.context!,
                          ).primaryColor.withOpacity(0.1),
                          deleteIconColor: Theme.of(Get.context!).primaryColor,
                          labelStyle: TextStyle(
                            color: Theme.of(Get.context!).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Theme.of(
                                Get.context!,
                              ).primaryColor.withOpacity(0.3),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Widget _buildAttendeeCard(int index) {
  //   final a = controller.attendees[index];
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: Colors.grey[200]!),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 15,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                 width: 40,
  //                 height: 40,
  //                 decoration: BoxDecoration(
  //                   color: Theme.of(Get.context!).primaryColor.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 child: Center(
  //                   child: Text(
  //                     "${index + 1}",
  //                     style: TextStyle(
  //                       color: Theme.of(Get.context!).primaryColor,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(width: 12),
  //               Expanded(
  //                 child: Text(
  //                   "Attendee ${index + 1}",
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //               IconButton(
  //                 icon: const Icon(Icons.delete_outline, color: Colors.red),
  //                 onPressed: () => controller.removeAttendee(index),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 16),
  //           _buildTextField("Name", a["name"]!, icon: Icons.person_outline),
  //           _buildTextField("Email", a["email"]!, icon: Icons.email_outlined),
  //           _buildTextField("Phone", a["phone"]!, icon: Icons.phone_outlined),
  //           _buildTextField("Status", a["status"]!, icon: Icons.info_outline),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Create Reminder",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Header Section
            _buildSectionHeader("Basic Information", icon: Icons.edit_note),

            _buildTextField(
              "Title",
              controller.titleController,
              icon: Icons.title,
            ),

            _buildTextField(
              "Description",
              controller.descController,
              maxLines: 3,
              icon: Icons.description_outlined,
            ),

            // Event Section
            _buildSectionHeader("Event Details", icon: Icons.event),

            _buildModernSwitch(
              "Enable reminder",
              controller.isEvent,
              icon: Icons.event_available,
            ),

            Obx(
              () => AnimatedCrossFade(
                firstChild: const SizedBox(),
                secondChild: Column(
                  children: [
                    _buildDropdown(
                      "Select Event Type",
                      controller.eventTypes,
                      controller.eventTypeController,
                      icon: Icons.category_outlined,
                    ),
                    _buildTextField(
                      "Location",
                      controller.locationController,
                      icon: Icons.location_on_outlined,
                    ),
                    _buildDateSelector(
                      "Select Start Date",
                      controller.startDate,
                      () => controller.pickDateTime(context, true),
                    ),
                    _buildDateSelector(
                      "Select End Date",
                      controller.endDate,
                      () => controller.pickDateTime(context, false),
                    ),
                  ],
                ),
                crossFadeState: controller.isEvent.value
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ),

            // Settings Section
            _buildSectionHeader("Settings", icon: Icons.settings_outlined),

            _buildModernSwitch(
              "All Day",
              controller.allDay,
              icon: Icons.access_time,
            ),

            _buildDropdown(
              "Select Category",
              controller.categories,
              controller.categoryController,
              icon: Icons.label_outline,
            ),

            // Notifications Section
            _buildSectionHeader(
              "Notifications",
              icon: Icons.notifications_outlined,
            ),

            _buildMethodInput(),

            _buildDropdown(
              "Select Notification Timing",
              controller.notificationTimingList,
              controller.notificationTimingController,
              icon: Icons.schedule,
            ),

            // Attendees Section
            // _buildSectionHeader("Attendees", icon: Icons.people_outline),
            // Obx(
            //   () => Column(
            //     children: List.generate(
            //       controller.attendees.length,
            //       (i) => _buildAttendeeCard(i),
            //     ),
            //   ),
            // ),
            // OutlinedButton.icon(
            //   onPressed: controller.addAttendee,
            //   icon: const Icon(Icons.person_add_outlined),
            //   label: const Text("Add Attendee"),
            //   style: OutlinedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(vertical: 16),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(16),
            //     ),
            //     side: BorderSide(color: Theme.of(context).primaryColor),
            //     foregroundColor: Theme.of(context).primaryColor,
            //   ),
            // ),
            const SizedBox(height: 32),

            // Submit Button
            Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.createReminder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    elevation: controller.isLoading.value ? 0 : 4,
                    shadowColor: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline),
                            SizedBox(width: 8),
                            Text(
                              "Create Reminder",
                              style: TextStyle(
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

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
