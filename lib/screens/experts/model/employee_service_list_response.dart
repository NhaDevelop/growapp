import 'package:grow_tokyo_app/screens/category/model/category_response.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';

class EmployeeServiceListResponse {
  final bool status;
  final String message;
  final List<EmployeeServiceListData> data;

  const EmployeeServiceListResponse(
      {required this.status, required this.message, required this.data});

  factory EmployeeServiceListResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeServiceListResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => EmployeeServiceListData.fromJson(e))
          .toList(),
    );
  }
}

class EmployeeServiceListData {
  final CategoryData category;
  final List<ServiceListData> services;

  const EmployeeServiceListData(
      {required this.category, required this.services});

  factory EmployeeServiceListData.fromJson(Map<String, dynamic> json) {
    return EmployeeServiceListData(
      category: CategoryData.fromJson(json['category']),
      services: (json['services'] as List)
          .map((e) => ServiceListData.fromJson(e))
          .toList(),
    );
  }
}
