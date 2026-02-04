class ReminderModel {
  String title;
  String description;

  String? eventStartDate;

  ReminderModel({
    required this.title,
    required this.description,
    required this.eventStartDate,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "eventStartDate": eventStartDate,
  };
}
