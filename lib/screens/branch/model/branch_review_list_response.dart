import '../../../models/review_data.dart';

class BranchReviewListResponse {
  List<ReviewData>? data;
  String? message;
  bool? status;

  BranchReviewListResponse({this.data, this.message, this.status});

  factory BranchReviewListResponse.fromJson(Map<String, dynamic> json) {
    return BranchReviewListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => ReviewData.fromJson(i)).toList() : null,
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
