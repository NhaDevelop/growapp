import 'package:grow_tokyo_app/screens/experts/model/employee_detail_response.dart';

class VerifyAnyStylistResponse {
  String message;
  bool status;
  EmployeeData data;

  VerifyAnyStylistResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory VerifyAnyStylistResponse.fromJson(Map<String, dynamic> json) {
    return VerifyAnyStylistResponse(
      message: json['message'],
      status: json['status'],
      data: EmployeeData.fromJson(json['data']),
    );
  }
}
