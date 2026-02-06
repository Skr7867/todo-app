import 'dart:developer';

import 'package:get/get.dart';

import '../../../hive/hive_service.dart';
import '../../../hive/notificationService/notification_service.dart';
import '../../../repository/deleteReminder/delete_reminder_repository.dart';
import '../../../utils/utils.dart';
import '../reminderDetails/reminder_details_controller.dart';
import '../user_preferences/user_preferences_viewmodel.dart';

class DeleteReminderController extends GetxController {
  /// ================= REPOSITORY =================
  final DeleteReminderRepository _repo = DeleteReminderRepository();

  /// ================= USER PREF =================
  final UserPreferencesViewmodel _userPref = UserPreferencesViewmodel();

  /// ================= STATES =================
  RxBool isDeleting = false.obs;
  RxString error = "".obs;

  /// =====================================================
  /// 🚀 DELETE REMINDER (API + HIVE + NOTIFICATION SYNC)
  /// =====================================================
  Future<void> deleteReminder(String reminderId) async {
    try {
      isDeleting.value = true;
      error.value = "";

      /// ================= TOKEN =================
      final user = await _userPref.getUser();
      final token = user.token ?? "";

      if (token.isEmpty) {
        throw Exception("Session expired. Please login again.");
      }

      /// ================= API DELETE =================
      final response = await _repo.deleteReminder(reminderId, token);

      log("✅ Delete API Response => $response");

      /// ================= CANCEL NOTIFICATION =================
      await NotificationService.cancel(reminderId.hashCode);

      /// ================= DELETE LOCAL HIVE =================
      final box = HiveService.reminderBox;

      if (box.containsKey(reminderId)) {
        await box.delete(reminderId);
        log("🗑 Local Hive Deleted => $reminderId");
      }

      /// ================= SUCCESS MESSAGE =================
      Utils.toastMessageCenter('Reminder Deleted Successfully');

      /// ================= REFRESH LIST =================
      if (Get.isRegistered<ReminderDetailsController>()) {
        Get.find<ReminderDetailsController>().fetchReminderDetails();
      }
    } catch (e) {
      error.value = e.toString();

      log("❌ Delete Reminder Error => $e");

      Get.snackbar("Error", error.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isDeleting.value = false;
    }
  }
}
