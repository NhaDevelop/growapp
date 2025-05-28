import 'package:grow_tokyo_app/screens/cart/model/logistic_zone_response.dart';

class CityListResponse {
  List<CityData>? data;
  String? message;
  bool? status;

  CityListResponse({this.data, this.message, this.status});

  factory CityListResponse.fromJson(Map<String, dynamic> json) {
    return CityListResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => CityData.fromJson(i)).toList()
          : null,
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
