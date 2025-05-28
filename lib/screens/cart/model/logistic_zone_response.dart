class LogisticZoneResponse {
  List<LogisticZoneData>? data;
  String? message;
  bool? status;

  LogisticZoneResponse({this.data, this.message, this.status});

  factory LogisticZoneResponse.fromJson(Map<String, dynamic> json) {
    return LogisticZoneResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => LogisticZoneData.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LogisticZoneData {
  List<CityData>? cities;
  int? countryId;
  num? expressDeliveryCharge;
  String? expressDeliveryTime;
  int? id;
  int? logisticId;
  String? logisticName;
  String? name;
  num? standardDeliveryCharge;
  String? standardDeliveryTime;
  int? stateId;
  bool isLogisticCheck;

  LogisticZoneData({
    this.cities,
    this.countryId,
    this.expressDeliveryCharge,
    this.expressDeliveryTime,
    this.id,
    this.logisticId,
    this.logisticName,
    this.name,
    this.standardDeliveryCharge,
    this.standardDeliveryTime,
    this.stateId,
    this.isLogisticCheck = false,
  });

  factory LogisticZoneData.fromJson(Map<String, dynamic> json) {
    return LogisticZoneData(
      cities: json['cities'] != null ? (json['cities'] as List).map((i) => CityData.fromJson(i)).toList() : null,
      countryId: json['country_id'],
      expressDeliveryCharge: json['express_delivery_charge'],
      expressDeliveryTime: json['express_delivery_time'],
      id: json['id'],
      logisticId: json['logistic_id'],
      logisticName: json['logistic_name'],
      name: json['name'],
      standardDeliveryCharge: json['standard_delivery_charge'],
      standardDeliveryTime: json['standard_delivery_time'],
      stateId: json['state_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['express_delivery_charge'] = expressDeliveryCharge;
    data['id'] = id;
    data['logistic_id'] = logisticId;
    data['logistic_name'] = logisticName;
    data['name'] = name;
    data['standard_delivery_charge'] = standardDeliveryCharge;
    data['state_id'] = stateId;
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    if (expressDeliveryTime != null) {
      data['express_delivery_time'] = expressDeliveryTime;
    }
    if (standardDeliveryTime != null) {
      data['standard_delivery_time'] = standardDeliveryTime;
    }
    return data;
  }
}

class CityData {
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  int? id;
  String? name;
  Pivot? pivot;
  int? stateId;
  int? status;
  String? updatedAt;
  int? updatedBy;

  CityData({this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.id, this.name, this.pivot, this.stateId, this.status, this.updatedAt, this.updatedBy});

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      id: json['id'],
      name: json['name'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
      stateId: json['state_id'],
      status: json['status'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['name'] = name;
    data['state_id'] = stateId;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    if (createdBy != null) {
      data['created_by'] = createdBy;
    }
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    if (deletedBy != null) {
      data['deleted_by'] = deletedBy;
    }
    if (pivot != null) {
      data['pivot'] = pivot;
    }
    if (updatedBy != null) {
      data['updated_by'] = updatedBy;
    }
    return data;
  }
}

class Pivot {
  int? cityId;
  int? logisticZoneId;

  Pivot({this.cityId, this.logisticZoneId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      cityId: json['city_id'],
      logisticZoneId: json['logistic_zone_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['logistic_zone_id'] = logisticZoneId;
    return data;
  }
}
