class NotificationListResponse {
  int? allUnreadCount;
  String? message;
  List<NotificationData>? notificationData;
  bool? status;

  NotificationListResponse(
      {this.allUnreadCount, this.message, this.notificationData, this.status});

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListResponse(
      allUnreadCount: json['all_unread_count'],
      message: json['message'],
      notificationData: json['notification_data'] != null
          ? (json['notification_data'] as List)
              .map((i) => NotificationData.fromJson(i))
              .toList()
          : null,
      status: json['status'],
    );
  }
}

class NotificationData {
  NotificationModel? data;
  String? createdAt;
  String? id;
  int? notifiableId;
  String? notifiableType;
  String? readAt;
  String? type;
  String? updatedAt;

  NotificationData(
      {this.data,
      this.createdAt,
      this.id,
      this.notifiableId,
      this.notifiableType,
      this.readAt,
      this.type,
      this.updatedAt});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      data: json['data'] != null
          ? NotificationModel.fromJson(json['data'])
          : null,
      createdAt: json['created_at'],
      id: json['id'],
      notifiableId: json['notifiable_id'],
      notifiableType: json['notifiable_type'],
      readAt: json['read_at'],
      type: json['type'],
      updatedAt: json['updated_at'],
    );
  }
}

class NotificationModel {
  NotificationDetail? notificationDetail;
  String? subject;
  int? bookingId; // Added to support backend's flat structure

  NotificationModel({this.notificationDetail, this.subject, this.bookingId});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationDetail: json['data'] != null
          ? NotificationDetail.fromJson(json['data'])
          : null,
      subject: json['subject'],
      bookingId: json['booking_id'] != null
          ? int.tryParse(json['booking_id'].toString())
          : null,
    );
  }
}

class NotificationDetail {
  String? bookingDate;
  String? orderDate;
  int? bookingDuration;
  String? bookingServicesNames;
  String? bookingTime;
  String? orderTime;
  String? companyContactInfo;
  String? companyName;
  String? description;
  int? employeeId;
  String? employeeName;
  int? id;
  String? loggedInUserFullName;
  String? loggedInUserRole;
  String? notificationGroup;
  String? notificationType;
  String? siteUrl;
  String? type;
  int? userId;
  String? userName;
  String? venueAddress;
  String? orderCode;
  String? content;

  NotificationDetail({
    this.bookingDate,
    this.orderDate,
    this.bookingDuration,
    this.bookingServicesNames,
    this.bookingTime,
    this.orderTime,
    this.companyContactInfo,
    this.companyName,
    this.description,
    this.employeeId,
    this.employeeName,
    this.id,
    this.loggedInUserFullName,
    this.loggedInUserRole,
    this.notificationGroup,
    this.notificationType,
    this.siteUrl,
    this.type,
    this.userId,
    this.userName,
    this.venueAddress,
    this.orderCode,
    this.content,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      bookingDate: json['booking_date'],
      orderDate: json['order_date'],
      bookingDuration: json['booking_duration'],
      bookingServicesNames: json['booking_services_names'],
      bookingTime: json['booking_time'],
      orderTime: json['order_time'],
      companyContactInfo: json['company_contact_info'],
      companyName: json['company_name'],
      description: json['description'],
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      id: json['id'],
      loggedInUserFullName: json['logged_in_user_fullname'],
      loggedInUserRole: json['logged_in_user_role'],
      notificationGroup: json['notification_group'],
      notificationType: json['notification_type'],
      siteUrl: json['site_url'],
      type: json['type'],
      userId: json['user_id'],
      userName: json['user_name'],
      venueAddress: json['venue_address'],
      orderCode: json['order_code'],
      content: json['content'],
    );
  }
}
