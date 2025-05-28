import 'package:grow_tokyo_app/main.dart';

class ServiceResponse {
  List<ServiceListData>? data;
  String? message;
  bool? status;

  ServiceResponse({this.data, this.message, this.status});

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => ServiceListData.fromJson(i))
              .toList()
          : null,
      message: json['message'],
      status: json['status'],
    );
  }
}

class ServiceListData {
  int? categoryId;
  String? createdAt;
  int? createdBy;
  int? defaultPrice;
  String? deletedAt;
  int? deletedBy;
  String? description;
  int? durationMin;
  int? id;
  String? name;
  String? serviceImage;
  String? slug;
  int? status;
  int? subCategoryId;
  String? updatedAt;
  int? updatedBy;
  String? startDateTime;
  DateTime? previousTime;

  bool isServiceChecked;

  // for booking wise service
  int? servicePrice;
  int? serviceId;
  String? serviceName;

  ServiceListData({
    this.categoryId,
    this.createdAt,
    this.createdBy,
    this.defaultPrice,
    this.servicePrice,
    this.deletedAt,
    this.deletedBy,
    this.description,
    this.durationMin,
    this.id,
    this.name,
    this.serviceId,
    this.serviceName,
    this.serviceImage,
    this.slug,
    this.status,
    this.subCategoryId,
    this.updatedAt,
    this.updatedBy,
    this.isServiceChecked = false,
    this.startDateTime,
  });

  factory ServiceListData.fromJson(Map<String, dynamic> json) {
    return ServiceListData(
      categoryId: json['category_id'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      defaultPrice: json['default_price'],
      servicePrice: json['service_price'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      description: json['description'],
      durationMin: json['duration_min'],
      id: json['id'],
      name: json['name'],
      serviceId: json['service_id'],
      serviceName: json['service_name'],
      serviceImage: json['service_image'],
      slug: json['slug'],
      status: json['status'],
      subCategoryId: json['sub_category_id'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
    );
  }

  /// For Save Booking
  Map<String, dynamic> toBookingServiceJson(
      {bool isUpdate = false, bool isRescheduleBooking = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = (isUpdate || isRescheduleBooking) ? serviceId : id;
    data['service_price'] =
        (isUpdate || isRescheduleBooking) ? servicePrice : defaultPrice;
    if (bookingRequestStore.employeeId != -1) {
      data['employee_id'] = bookingRequestStore.employeeId;
    }
    data['duration_min'] = durationMin;
    data['start_date_time'] = startDateTime;
    return data;
  }
}
