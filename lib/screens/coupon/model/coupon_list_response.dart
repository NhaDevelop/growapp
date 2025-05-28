class CouponListResponse {
  final List<CouponData> couponList;

  CouponListResponse({required this.couponList});

  factory CouponListResponse.fromJson(Map<String, dynamic> json) {
    List<CouponData> couponList = [];
    couponList = (json['data'] as List)
        .map((coupon) => CouponData.fromJson(coupon))
        .toList();
    return CouponListResponse(couponList: couponList);
  }
}

class CouponData {
  final String name;
  final String code;
  final String description;
  final DateTime validUntil;
  final double discountPercentage;

  CouponData(
      {required this.name,
      required this.code,
      required this.description,
      required this.validUntil,
      required this.discountPercentage});

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      name: json['name'],
      code: json['code'],
      description: json['description'],
      validUntil: DateTime.parse(json['valid_until']).toLocal(),
      discountPercentage: (json['discount_percentage'] as num).toDouble(),
    );
  }
}
