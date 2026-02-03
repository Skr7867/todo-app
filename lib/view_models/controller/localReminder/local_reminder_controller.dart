import 'package:get/get.dart';

import '../../../models/reminder/local_reminders_model.dart';
import '../../../repository/localReminder/local_reminder_repository.dart';

class LocalReminderController extends GetxController {
  final repo = LocalReminderRepository();

  RxList<ReminderModel> reminders = <ReminderModel>[].obs;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  void load() {
    reminders.value = repo.getAll();
  }

  Future create(ReminderModel reminder) async {
    await repo.save(reminder);
    load();
  }

  Future delete(int id) async {
    await repo.delete(id);

    reminders.removeWhere((e) => e.id == id);

    reminders.refresh();
  }
}
