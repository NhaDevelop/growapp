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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
