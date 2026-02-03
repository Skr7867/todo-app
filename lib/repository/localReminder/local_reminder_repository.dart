import 'dart:developer';
import '../../hive/hive_service.dart';
import '../../hive/notificationService/notification_service.dart';
import '../../models/reminder/local_reminders_model.dart';

class LocalReminderRepository {
  Future save(ReminderModel reminder) async {
    try {
      print("Saving reminder ${reminder.title} at ${reminder.dateTime}");

      // Save to Hive
      await HiveService.box.put(reminder.id, reminder.toJson());
      print("✅ Saved to Hive");

      // Schedule notification - Make sure dateTime is in future
      final now = DateTime.now();
      if (reminder.dateTime.isAfter(now)) {
        await NotificationService.schedule(
          id: reminder.id,
          title: reminder.title,
          body: reminder.description,
          dateTime: reminder.dateTime,
        );
        log("✅ Notification Scheduled");
      } else {
        log("⚠️ Reminder time is in past, not scheduling notification");
      }
    } catch (e) {
      log("❌ Save Error => $e");
    }
  }

  List<ReminderModel> getAll() {
    return HiveService.box.toMap().entries.map((entry) {
      final map = Map<String, dynamic>.from(entry.value);

      /// ensure id is correct
      map["id"] = entry.key;

      return ReminderModel.fromJson(map);
    }).toList();
  }

  Future delete(int id) async {
    log("Deleting Hive Key => $id");

    await HiveService.box.delete(id);
    log("✅ Hive delete success");

    await NotificationService.cancel(id);
    log("✅ Notification cancel success");
  }
}
