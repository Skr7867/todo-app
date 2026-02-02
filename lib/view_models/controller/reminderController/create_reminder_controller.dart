import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmvvm/res/routes/routes_name.dart';
import 'package:getxmvvm/utils/utils.dart';

import '../../../models/reminder/reminder_model.dart';
import '../../../repository/createReminder/create_reminder_repository.dart';
import '../user_preferences/user_preferences_viewmodel.dart';

class CreateReminderController extends GetxController {
  /// REPOSITORY
  final _repo = CreateReminderRepository();

  /// USER PREF
  final _userPref = UserPreferencesViewmodel();

  /// FORM KEY
  final formKey = GlobalKey<FormState>();

  /// LOADING
  RxBool isLoading = false.obs;

  /// TEXT CONTROLLERS
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final eventTypeController = TextEditingController();
  final locationController = TextEditingController();
  final categoryController = TextEditingController();
  final notificationTimingController = TextEditingController();
  final methodController = TextEditingController();

  /// RX STATE
  RxBool isEvent = false.obs;
  RxBool allDay = false.obs;

  Rxn<DateTime> startDate = Rxn<DateTime>();
  Rxn<DateTime> endDate = Rxn<DateTime>();

  RxList<String> notificationMethods = <String>[].obs;
  RxList<Map<String, TextEditingController>> attendees =
      <Map<String, TextEditingController>>[].obs;

  /// ENUM LISTS (BACKEND SAFE)
  final eventTypes = [
    "birthday",
    "anniversary",
    "meeting",
    "appointment",
    "holiday",
    "festival",
    "custom",
    "work",
    "personal",
    "health",
  ];

  final categories = [
    "personal",
    "work",
    "health",
    "finance",
    "shopping",
    "birthday",
    "meeting",
    "appointment",
    "festival",
    "holiday",
    "travel",
    "education",
    "family",
    "other",
  ];

  final notificationTimingList = [
    "exact",
    "5min_before",
    "15min_before",
    "30min_before",
    "1hr_before",
    "2hr_before",
    "6hr_before",
    "12hr_before",
    "1day_before",
    "2days_before",
    "1week_before",
  ];

  /// METHODS
  void addMethod() {
    if (methodController.text.isNotEmpty) {
      notificationMethods.add(methodController.text);
      methodController.clear();
    }
  }

  void removeMethod(String method) {
    notificationMethods.remove(method);
  }

  /// DATE PICKER
  Future pickDateTime(BuildContext context, bool isStart) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final finalDT = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (isStart) {
      startDate.value = finalDT;
    } else {
      endDate.value = finalDT;
    }
  }

  /// 🚀 CREATE REMINDER
  Future<void> createReminder() async {
    if (!formKey.currentState!.validate()) return;

    /// DATE VALIDATION
    if (startDate.value != null && endDate.value != null) {
      if (endDate.value!.isBefore(startDate.value!)) {
        Utils.snackBar("End date must be after start date", "Info");
        return;
      }
    }

    /// METHOD VALIDATION
    if (notificationMethods.isEmpty) {
      Utils.snackBar("Add at least 1 notification method", "Info");
      return;
    }

    if (isEvent.isFalse) {
      Utils.snackBar('Please enable reminder', 'Info');
      return;
    }

    if (titleController.text.isEmpty) {
      Utils.snackBar('Title can not be empty', 'Info');
    }
    if (descController.text.isEmpty) {
      Utils.snackBar('description can not be empty', 'Info');
    }
    if (notificationTimingController.text.isEmpty) {
      Utils.snackBar("Please notification timing", 'Info');
      return;
    }

    try {
      isLoading.value = true;

      /// TOKEN
      final user = await _userPref.getUser();
      final token = user.token ?? "";

      /// MODEL
      final reminder = ReminderModel(
        title: titleController.text,
        description: descController.text,
        isEvent: isEvent.value,
        eventType: eventTypeController.text,
        eventStartDate: startDate.value?.toIso8601String(),
        eventEndDate: endDate.value?.toIso8601String(),
        location: locationController.text,
        allDay: allDay.value,
        category: categoryController.text,
        notificationMethods: notificationMethods,
        notificationTiming: notificationTimingController.text,
      );

      /// API CALL
      final response = await _repo.createReminderApi(reminder.toJson(), token);

      Utils.snackBar("Reminder Created Successfully", "Success");
      Get.toNamed(RouteName.reminderDetailsScreen);
      log(response);
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
