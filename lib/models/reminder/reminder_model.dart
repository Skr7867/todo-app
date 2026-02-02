class ReminderModel {
  String title;
  String description;
  bool isEvent;
  String eventType;
  String? eventStartDate;
  String? eventEndDate;
  String location;
  bool allDay;
  String category;
  List<String> notificationMethods;
  String notificationTiming;
  List<Map<String, dynamic>> attendees;

  ReminderModel({
    required this.title,
    required this.description,
    required this.isEvent,
    required this.eventType,
    this.eventStartDate,
    this.eventEndDate,
    required this.location,
    required this.allDay,
    required this.category,
    required this.notificationMethods,
    required this.notificationTiming,
    required this.attendees,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "isEvent": isEvent,
    "eventType": eventType,
    "eventStartDate": eventStartDate,
    "eventEndDate": eventEndDate,
    "location": location,
    "allDay": allDay,
    "category": category,
    "notificationMethods": notificationMethods,
    "notificationTiming": notificationTiming,
    "attendees": attendees,
  };
}
