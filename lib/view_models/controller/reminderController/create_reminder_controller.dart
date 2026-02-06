import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/reminder/reminder_model.dart';
import '../../../repository/createReminder/create_reminder_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../user_preferences/user_preferences_viewmodel.dart';

class CreateReminderController extends GetxController {
  /// ================= REPOSITORY =================
  final _repo = CreateReminderRepository();

  /// ================= USER PREF =================
  final _userPref = UserPreferencesViewmodel();

  /// ================= FORM =================
  final formKey = GlobalKey<FormState>();

  /// ================= LOADING =================
  RxBool isLoading = false.obs;

  /// ================= TEXT CONTROLLERS =================
  final titleController = TextEditingController();
  final descController = TextEditingController();

  /// ================= RX STATE =================
  RxString notificationTiming = "30min_before".obs;
  RxBool allDay = false.obs;
  Rxn<DateTime> startDate = Rxn<DateTime>();
  final List<Map<String, String>> timingOptions = [
    {"value": "exact", "label": "At exact time"},
    {"value": "5min_before", "label": "5 minutes before"},
    {"value": "15min_before", "label": "15 minutes before"},
    {"value": "30min_before", "label": "30 minutes before"},
    {"value": "1hr_before", "label": "1 hour before"},
    {"value": "2hr_before", "label": "2 hours before"},
    {"value": "6hr_before", "label": "6 hours before"},
    {"value": "12hr_before", "label": "12 hours before"},
    {"value": "1day_before", "label": "1 day before"},
    {"value": "2days_before", "label": "2 days before"},
    {"value": "1week_before", "label": "1 week before"},
  ];

  /// ====================================================
  /// 📅 DATE + TIME PICKER
  /// ====================================================
  Future pickDateTime(BuildContext context, bool isStart) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: startDate.value ?? DateTime.now(),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(startDate.value ?? DateTime.now()),
    );

    if (time == null) return;

    final selectedDT = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (isStart) {
      startDate.value = selectedDT;
    }
  }

  /// ====================================================
  /// 🧠 CLEAN DATE → REMOVE SECONDS → CONVERT TO UTC
  /// ====================================================
  String? getUtcIsoTime() {
    if (startDate.value == null) return null;

    final dt = startDate.value!;

    /// Remove seconds & milliseconds (Prevents drift)
    final cleanLocal = DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute);

    /// Convert to UTC
    final utc = cleanLocal.toUtc();

    return utc.toIso8601String();
  }

  /// ====================================================
  /// 🚀 CREATE REMINDER (API)
  /// ====================================================
  Future<void> createReminder() async {
    if (!formKey.currentState!.validate()) return;

    if (startDate.value == null) {
      Utils.snackBar('Please select reminder time', 'Info');
      return;
    }

    try {
      isLoading.value = true;

      /// ================= TOKEN =================
      final user = await _userPref.getUser();
      final token = user.token ?? "";

      /// ================= MODEL =================
      final reminder = ReminderModel(
        title: titleController.text.trim(),
        description: descController.text.trim(),
        eventStartDate: getUtcIsoTime(),
        notificationTiming: notificationTiming.value,
      );

      log("Sending Time (UTC): ${getUtcIsoTime()}");

      /// ================= API CALL =================
      final response = await _repo.createReminderApi(reminder.toJson(), token);

      log("Create Reminder Response: $response");

      Utils.snackBar("Reminder Created Successfully", "Success");

      /// Navigate
      Get.toNamed(RouteName.reminderDetailsScreen);
    } catch (e) {
      log("Create Reminder Error: $e");

      Utils.snackBar('Failed to create reminder', 'Failed');
    } finally {
      isLoading.value = false;
    }
  }

  /// ====================================================
  /// 🧹 DISPOSE CONTROLLERS
  /// ====================================================
  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    super.onClose();
  }
}
