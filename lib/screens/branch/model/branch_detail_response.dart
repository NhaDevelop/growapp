import 'branch_response.dart';

class BranchDetailResponse {
  BranchData? data;
  String? message;
  bool? status;

  BranchDetailResponse({this.data, this.message, this.status});

  factory BranchDetailResponse.fromJson(Map<String, dynamic> json) {
    return BranchDetailResponse(
      data: json['data'] != null ? BranchData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }
}
