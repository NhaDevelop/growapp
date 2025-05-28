import '../../experts/model/employee_detail_response.dart';

class BranchEmployeeListResponse {
    List<EmployeeData>? data;
    String? message;
    bool? status;

    BranchEmployeeListResponse({this.data, this.message, this.status});

    factory BranchEmployeeListResponse.fromJson(Map<String, dynamic> json) {
        return BranchEmployeeListResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => EmployeeData.fromJson(i)).toList() : null,
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
