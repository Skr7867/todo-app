import 'dart:developer';

import 'package:get/get.dart';

import '../../../models/notification/notification_history_model.dart';
import '../../../repository/notification/notification_history_repository.dart';
import '../user_preferences/user_preferences_viewmodel.dart';

class NotificationController extends GetxController {
  /// ================= REPOSITORY =================
  final NotificationHistoryRepository _repository =
      NotificationHistoryRepository();

  /// ================= USER PREF =================
  final UserPreferencesViewmodel _userPref = UserPreferencesViewmodel();

  /// ================= STATES =================
  RxBool isLoading = false.obs;
  RxBool isRefreshing = false.obs;

  RxString errorMessage = "".obs;

  /// ================= DATA =================
  Rxn<NotificationHistoryModel> notificationResponse =
      Rxn<NotificationHistoryModel>();

  RxList<Notifications> notificationsList = <Notifications>[].obs;

  /// ================= PAGINATION (Future Safe) =================
  RxInt page = 1.obs;
  RxBool hasMore = true.obs;

  /// ==========================================================
  /// INIT
  /// ==========================================================
  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  /// ==========================================================
  /// FETCH NOTIFICATIONS
  /// ==========================================================
  Future<void> fetchNotifications({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        isRefreshing.value = true;
      } else {
        isLoading.value = true;
      }

      errorMessage.value = "";

      /// ===== GET TOKEN =====
      final user = await _userPref.getUser();
      final token = user.token ?? "";

      if (token.isEmpty) {
        throw Exception("Session expired. Please login again.");
      }

      /// ===== API CALL =====
      final response = await _repository.getNotification(token);

      notificationResponse.value = response;

      /// ===== ASSIGN LIST =====
      final list = response.data?.notifications ?? [];

      if (isRefresh) {
        notificationsList.assignAll(list);
      } else {
        notificationsList.addAll(list);
      }

      /// ===== PAGINATION FLAG (OPTIONAL) =====
      hasMore.value = list.isNotEmpty;

      log("✅ Notification Loaded: ${list.length}");
    } catch (e) {
      errorMessage.value = e.toString();

      log("❌ Notification Fetch Error => $e");

      Get.snackbar(
        "Error",
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      isRefreshing.value = false;
    }
  }

  /// ==========================================================
  /// PULL TO REFRESH
  /// ==========================================================
  Future<void> refreshNotifications() async {
    page.value = 1;
    notificationsList.clear();
    await fetchNotifications(isRefresh: true);
  }

  /// ==========================================================
  /// LOAD MORE (FOR PAGINATION FUTURE)
  /// ==========================================================
  Future<void> loadMore() async {
    if (!hasMore.value || isLoading.value) return;

    page.value++;

    await fetchNotifications();
  }
}
