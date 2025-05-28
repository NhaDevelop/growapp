import 'package:grow_tokyo_app/models/review_data.dart';

class EmployeeReviewResponse {
  List<ReviewData>? reviewData;
  String? message;
  bool? status;

  EmployeeReviewResponse({this.reviewData, this.message, this.status});

  factory EmployeeReviewResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeReviewResponse(
      reviewData: json['data'] != null
          ? (json['data'] as List).map((i) => ReviewData.fromJson(i)).toList()
          : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (reviewData != null) {
      data['data'] = reviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
