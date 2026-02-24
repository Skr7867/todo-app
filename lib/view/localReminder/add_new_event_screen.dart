import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../view_models/controller/reminderController/create_reminder_controller.dart';

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({super.key});

  @override
  State<AddNewEventScreen> createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  final CreateReminderController controller = Get.put(
    CreateReminderController(),
  );

  String selectedCategory = "Birthday";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E2A1E),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F3A28), Color(0xFF0A2017)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                      ),
                      const Text(
                        "Add New Event",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// GENERAL INFO
                  const Text(
                    "GENERAL INFO",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// EVENT NAME (CONNECTED)
                  TextFormField(
                    controller: controller.titleController,
                    style: const TextStyle(color: Colors.white),
                    validator: (v) => v!.isEmpty ? "Enter event title" : null,
                    decoration: InputDecoration(
                      hintText: "Event Name",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF163D2B),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// STATIC CATEGORY (NOT SENT TO BACKEND)
                  Row(
                    children: ["Birthday", "Anniversary", "Holiday"]
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = e;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedCategory == e
                                      ? Colors.greenAccent
                                      : const Color(0xFF163D2B),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    color: selectedCategory == e
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 30),

                  /// WHEN
                  const Text(
                    "WHEN?",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// DATE + TIME (CONNECTED)
                  Obx(() {
                    final dt = controller.startDate.value;

                    final selectedDate = dt != null
                        ? DateFormat("MMM dd, yyyy").format(dt)
                        : "Select Date";

                    final selectedTime = dt != null
                        ? DateFormat("hh:mm a").format(dt)
                        : "Select Time";

                    return Row(
                      children: [
                        /// DATE CARD
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: dt ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                final currentTime = dt != null
                                    ? TimeOfDay.fromDateTime(dt)
                                    : TimeOfDay.now();

                                controller.startDate.value = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  currentTime.hour,
                                  currentTime.minute,
                                );
                              }
                            },
                            child: _dateTimeCard(
                              icon: Icons.calendar_today,
                              label: "Date",
                              value: selectedDate,
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        /// TIME CARD
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: dt != null
                                    ? TimeOfDay.fromDateTime(dt)
                                    : TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                final currentDate = dt ?? DateTime.now();

                                controller.startDate.value = DateTime(
                                  currentDate.year,
                                  currentDate.month,
                                  currentDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                              }
                            },
                            child: _dateTimeCard(
                              icon: Icons.access_time,
                              label: "Time",
                              value: selectedTime,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 30),

                  /// REMINDER TIMING (FULL OPTIONS)
                  const Text(
                    "REMIND ME",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Obx(
                    () => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: controller.timingOptions.map((option) {
                        final isSelected =
                            controller.notificationTiming.value ==
                            option["value"];

                        return ChoiceChip(
                          label: Text(option["label"]!),
                          selected: isSelected,
                          selectedColor: Colors.greenAccent,
                          backgroundColor: const Color(0xFF163D2B),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                          onSelected: (_) {
                            controller.notificationTiming.value =
                                option["value"]!;
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// NOTES (CONNECTED)
                  const Text(
                    "NOTES & IDEAS",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: controller.descController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Write description here...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF163D2B),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// SAVE BUTTON (CONNECTED)
                  Obx(
                    () => SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.createReminder,
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const Text(
                                "Save Event",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateTimeCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: const Color(0xFF163D2B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.greenAccent, size: 26),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
