class ReminderModel {
  int id;
  String title;
  String description;
  DateTime dateTime;

  ReminderModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "dateTime": dateTime.toIso8601String(),
  };

  factory ReminderModel.fromJson(Map json) => ReminderModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    dateTime: DateTime.parse(json["dateTime"]),
  );
}
