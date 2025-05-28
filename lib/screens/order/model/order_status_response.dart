class OrderStatusResponse {
  List<OrderStatusData>? data;
  String? message;
  bool? status;

  OrderStatusResponse({this.data, this.message, this.status});

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return OrderStatusResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => OrderStatusData.fromJson(i)).toList() : null,
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

class OrderStatusData {
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  int? id;
  String? name;
  int? sequence;
  int? status;
  String? subType;
  String? type;
  String? updatedAt;
  int? updatedBy;
  String? value;

  OrderStatusData({
    this.createdAt,
    this.createdBy,
    this.deletedAt,
    this.deletedBy,
    this.id,
    this.name,
    this.sequence,
    this.status,
    this.subType,
    this.type,
    this.updatedAt,
    this.updatedBy,
    this.value,
  });

  factory OrderStatusData.fromJson(Map<String, dynamic> json) {
    return OrderStatusData(
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      id: json['id'],
      name: json['name'],
      sequence: json['sequence'],
      status: json['status'],
      subType: json['sub_type'],
      type: json['type'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['name'] = name;
    data['sequence'] = sequence;
    data['status'] = status;
    data['type'] = type;
    data['updated_at'] = updatedAt;
    data['value'] = value;
    if (createdBy != null) {
      data['created_by'] = createdBy;
    }
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    if (deletedBy != null) {
      data['deleted_by'] = deletedBy;
    }
    if (subType != null) {
      data['sub_type'] = subType;
    }
    if (updatedBy != null) {
      data['updated_by'] = updatedBy;
    }
    return data;
  }
}
