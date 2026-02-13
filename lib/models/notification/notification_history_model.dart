class NotificationHistoryModel {
  bool? success;
  String? message;
  Data? data;

  NotificationHistoryModel({this.success, this.message, this.data});

  NotificationHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
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
        notifications!.add(Notifications.fromJson(v));
      });
    }
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
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
        ? ReminderId.fromJson(json['reminderId'])
        : null;
    title = json['title'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    sentAt = json['sentAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['userId'] = userId;
    if (reminderId != null) {
      data['reminderId'] = reminderId!.toJson();
    }
    data['title'] = title;
    data['message'] = message;
    data['type'] = type;
    data['status'] = status;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['sentAt'] = sentAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['eventStartDate'] = eventStartDate;
    data['sentAt'] = sentAt;
    data['notificationSent'] = notificationSent;
    data['notificationCount'] = notificationCount;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['deliveryMethod'] = deliveryMethod;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = nId;
    data['totalReminders'] = totalReminders;
    data['sentReminders'] = sentReminders;
    data['failedReminders'] = failedReminders;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['totalPages'] = totalPages;
    data['hasNextPage'] = hasNextPage;
    data['hasPrevPage'] = hasPrevPage;
    return data;
  }
}
