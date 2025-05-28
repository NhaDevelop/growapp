import 'order_detail_response.dart';

class OrderListResponse {
  List<OrderListData>? data;
  String? message;
  bool? status;

  OrderListResponse({this.data, this.message, this.status});

  factory OrderListResponse.fromJson(Map<String, dynamic> json) {
    return OrderListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => OrderListData.fromJson(i)).toList() : null,
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
