class ReminderDetailsModel {
  bool? success;
  String? message;
  Data? data;

  ReminderDetailsModel({this.success, this.message, this.data});

  factory ReminderDetailsModel.fromJson(Map<String, dynamic> json) {
    return ReminderDetailsModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  List<Reminders> reminders;
  Pagination? pagination;

  Data({this.reminders = const [], this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      reminders: (json['reminders'] as List? ?? [])
          .map((e) => Reminders.fromJson(e))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class Reminders {
  String? id;
  String? title;
  String? description;
  String? reminderDate;
  bool? isEvent;
  String? eventType;
  String? eventStartDate;
  String? eventEndDate;
  String? location;
  bool? allDay;
  String? category;
  String? notificationTiming;

  List<String> notificationMethods;
  List<Attendees> attendees;

  Reminders({
    this.id,
    this.title,
    this.description,
    this.reminderDate,
    this.isEvent,
    this.eventType,
    this.eventStartDate,
    this.eventEndDate,
    this.location,
    this.allDay,
    this.category,
    this.notificationTiming,
    this.notificationMethods = const [],
    this.attendees = const [],
  });

  factory Reminders.fromJson(Map<String, dynamic> json) {
    return Reminders(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      reminderDate: json['reminderDate'],
      isEvent: json['isEvent'],
      eventType: json['eventType'],
      eventStartDate: json['eventStartDate'],
      eventEndDate: json['eventEndDate'],
      location: json['location'],
      allDay: json['allDay'],
      category: json['category'],
      notificationTiming: json['notificationTiming'],
      notificationMethods: (json['notificationMethods'] as List? ?? [])
          .cast<String>(),
      attendees: (json['attendees'] as List? ?? [])
          .map((e) => Attendees.fromJson(e))
          .toList(),
    );
  }
}

class Attendees {
  String? name;
  String? email;
  String? phone;
  String? status;

  Attendees({this.name, this.email, this.phone, this.status});

  factory Attendees.fromJson(Map<String, dynamic> json) {
    return Attendees(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
    );
  }
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Pagination({this.total, this.page, this.limit, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}
