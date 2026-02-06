import 'package:hive/hive.dart';

part 'reminder_details_model.g.dart';

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

@HiveType(typeId: 0)
class Reminders extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? reminderDate;

  @HiveField(4)
  bool? isEvent;

  @HiveField(5)
  String? eventType;

  @HiveField(6)
  String? eventStartDate;

  @HiveField(7)
  String? eventEndDate;

  @HiveField(8)
  String? location;

  @HiveField(9)
  bool? allDay;

  @HiveField(10)
  String? category;

  @HiveField(11)
  String? notificationTiming;

  @HiveField(12)
  List<String> notificationMethods;

  Reminders({
    this.id,
    this.title,
    this.description,
    this.eventStartDate,
    this.isEvent,
    this.eventType,
    this.reminderDate,
    this.eventEndDate,
    this.location,
    this.allDay,
    this.category,
    this.notificationTiming,
    this.notificationMethods = const [],
  });

  factory Reminders.fromJson(Map<String, dynamic> json) {
    return Reminders(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      eventStartDate: json['eventStartDate'],
      isEvent: json['isEvent'],
      eventType: json['eventType'],
      reminderDate: json['eventStartDate'],
      eventEndDate: json['eventEndDate'],
      location: json['location'],
      allDay: json['allDay'],
      category: json['category'],
      notificationTiming: json['notificationTiming'],
      notificationMethods: (json['notificationMethods'] as List? ?? [])
          .cast<String>(),
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
