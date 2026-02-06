import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Reminders extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? eventStartDate;

  @HiveField(4)
  String? category;

  Reminders({
    this.id,
    this.title,
    this.description,
    this.eventStartDate,
    this.category,
  });
}
