import 'package:get/get.dart';

import '../../../hive/hive_service.dart';
import '../../../hive/notificationService/notification_service.dart';
import '../../../models/reminderDetails/reminder_details_model.dart';
import '../../../repository/reminderDetails/reminder_details_repository.dart';
import '../user_preferences/user_preferences_viewmodel.dart';

class ReminderDetailsController extends GetxController {
  final ReminderDetailsRepository _repo = ReminderDetailsRepository();
  final UserPreferencesViewmodel _userPref = UserPreferencesViewmodel();

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  Rxn<ReminderDetailsModel> reminderResponse = Rxn();
  RxList<Reminders> remindersList = <Reminders>[].obs;

  @override
  void onInit() {
    fetchReminderDetails();
    super.onInit();
  }

  Future<void> fetchReminderDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final user = await _userPref.getUser();
      final token = user.token ?? "";

      final response = await _repo.reminderDetailsApi(token);

      reminderResponse.value = response;
      remindersList.assignAll(response.data?.reminders ?? []);

      await _syncLocalAndSchedule(remindersList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _syncLocalAndSchedule(List<Reminders> list) async {
    final box = HiveService.reminderBox;

    for (var r in list) {
      if (r.id == null || r.eventStartDate == null) continue;

      /// SAVE HIVE
      await box.put(r.id, r);

      /// SCHEDULE
      final dt = DateTime.parse(r.eventStartDate!).toLocal();

      await NotificationService.cancel(r.id.hashCode);

      await NotificationService.schedule(
        id: r.id.hashCode,
        title: r.title ?? "Reminder",
        body: r.description ?? "",
        dateTime: dt,
      );
    }
  }
}
