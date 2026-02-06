class NotificationHistoryModel {
  bool? success;
  String? message;
  Data? data;

  NotificationHistoryModel({this.success, this.message, this.data});

  NotificationHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Notifications>? notifications;
  Stats? stats;
  Pagination? pagination;

  Data({this.notifications, this.stats, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] = this.notifications!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Notifications {
  String? sId;
  String? userId;
  ReminderId? reminderId;
  String? title;
  String? message;
  String? type;
  String? status;
  Metadata? metadata;
  String? sentAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Notifications({
    this.sId,
    this.userId,
    this.reminderId,
    this.title,
    this.message,
    this.type,
    this.status,
    this.metadata,
    this.sentAt,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    reminderId = json['reminderId'] != null
        ? new ReminderId.fromJson(json['reminderId'])
        : null;
    title = json['title'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    sentAt = json['sentAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.reminderId != null) {
      data['reminderId'] = this.reminderId!.toJson();
    }
    data['title'] = this.title;
    data['message'] = this.message;
    data['type'] = this.type;
    data['status'] = this.status;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['sentAt'] = this.sentAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ReminderId {
  String? sId;
  String? title;
  String? eventStartDate;
  String? sentAt;
  bool? notificationSent;
  int? notificationCount;

  ReminderId({
    this.sId,
    this.title,
    this.eventStartDate,
    this.sentAt,
    this.notificationSent,
    this.notificationCount,
  });

  ReminderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    eventStartDate = json['eventStartDate'];
    sentAt = json['sentAt'];
    notificationSent = json['notificationSent'];
    notificationCount = json['notificationCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['eventStartDate'] = this.eventStartDate;
    data['sentAt'] = this.sentAt;
    data['notificationSent'] = this.notificationSent;
    data['notificationCount'] = this.notificationCount;
    return data;
  }
}

class Metadata {
  Null error;
  String? deliveryMethod;

  Metadata({this.error, this.deliveryMethod});

  Metadata.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    deliveryMethod = json['deliveryMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['deliveryMethod'] = this.deliveryMethod;
    return data;
  }
}

class Stats {
  Null nId;
  int? totalReminders;
  int? sentReminders;
  int? failedReminders;

  Stats({
    this.nId,
    this.totalReminders,
    this.sentReminders,
    this.failedReminders,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    totalReminders = json['totalReminders'];
    sentReminders = json['sentReminders'];
    failedReminders = json['failedReminders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.nId;
    data['totalReminders'] = this.totalReminders;
    data['sentReminders'] = this.sentReminders;
    data['failedReminders'] = this.failedReminders;
    return data;
  }
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    return data;
  }
}
