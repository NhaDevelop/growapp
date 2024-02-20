import 'employee_detail_response.dart';

class EmployeeResponse {
  List<EmployeeData>? topExperts;
  String? message;
  bool? status;

  EmployeeResponse({this.topExperts, this.message, this.status});

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      topExperts: json['data'] != null ? (json['data'] as List).map((i) => EmployeeData.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (topExperts != null) {
      data['data'] = topExperts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

