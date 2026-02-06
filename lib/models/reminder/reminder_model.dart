class ReminderModel {
  String title;
  String description;
  String? eventStartDate;
  String? notificationTiming;

  ReminderModel({
    required this.title,
    required this.description,
    required this.eventStartDate,
    required this.notificationTiming,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "eventStartDate": eventStartDate,
    'notificationTiming': notificationTiming,
  };
}
