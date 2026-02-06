import 'package:hive_flutter/hive_flutter.dart';

import '../models/reminderDetails/reminder_details_model.dart';

class HiveService {
  static const reminderBoxName = "reminders";

  static Future init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(RemindersAdapter());
    }

    if (!Hive.isBoxOpen(reminderBoxName)) {
      await Hive.openBox<Reminders>(reminderBoxName);
    }
  }

  static Box<Reminders> get reminderBox => Hive.box<Reminders>(reminderBoxName);
}
