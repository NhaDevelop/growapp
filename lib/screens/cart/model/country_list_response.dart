class CountryListResponse {
  List<CountryData>? data;
  String? message;
  bool? status;

  CountryListResponse({this.data, this.message, this.status});

  factory CountryListResponse.fromJson(Map<String, dynamic> json) {
    return CountryListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => CountryData.fromJson(i)).toList() : null,
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

class CountryData {
  int? id;
  String? name;

  CountryData({this.id, this.name});

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
