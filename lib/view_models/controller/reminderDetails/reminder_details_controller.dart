import 'package:get/get.dart';

import '../../../models/reminderDetails/reminder_details_model.dart';
import '../../../repository/reminderDetails/reminder_details_repository.dart';
import '../user_preferences/user_preferences_viewmodel.dart';

class ReminderDetailsController extends GetxController {
  /// REPOSITORY
  final ReminderDetailsRepository _repo = ReminderDetailsRepository();

  /// USER PREF
  final UserPreferencesViewmodel _userPref = UserPreferencesViewmodel();

  /// STATES
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  /// DATA
  Rxn<ReminderDetailsModel> reminderResponse = Rxn<ReminderDetailsModel>();

  /// SHORTCUT → reminders list
  RxList<Reminders> remindersList = <Reminders>[].obs;

  @override
  void onInit() {
    fetchReminderDetails();
    super.onInit();
  }

  /// 🚀 FETCH FROM API
  Future<void> fetchReminderDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      /// GET TOKEN
      final user = await _userPref.getUser();
      final token = user.token ?? "";

      if (token.isEmpty) {
        throw Exception("Token not found. Please login again.");
      }

      /// API CALL
      final response = await _repo.reminderDetailsApi(token);

      reminderResponse.value = response;

      /// Extract List
      remindersList.assignAll(response.data?.reminders ?? []);

      print("✅ Reminder Details Loaded");
    } catch (e) {
      errorMessage.value = e.toString();
      print("❌ Reminder Details Error => $e");

      Get.snackbar(
        "Error",
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔄 REFRESH SUPPORT
  Future<void> refreshData() async {
    await fetchReminderDetails();
  }
}
