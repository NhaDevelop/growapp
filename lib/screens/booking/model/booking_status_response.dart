class BookingStatusResponse {
  List<BookingStatusData>? data;
  String? message;
  bool? status;

  BookingStatusResponse({this.data, this.message, this.status});

  factory BookingStatusResponse.fromJson(Map<String, dynamic> json) {
    return BookingStatusResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => BookingStatusData.fromJson(i)).toList() : null,
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

class BookingStatusData {
  String? colorHex;
  bool? isDisabled;
  String? status;
  String? title;

  BookingStatusData({this.colorHex, this.isDisabled, this.status, this.title});

  factory BookingStatusData.fromJson(Map<String, dynamic> json) {
    return BookingStatusData(
      colorHex: json['color_hex'],
      isDisabled: json['is_disabled'],
      status: json['status'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color_hex'] = colorHex;
    data['is_disabled'] = isDisabled;
    data['status'] = status;
    data['title'] = title;
    return data;
  }
}
