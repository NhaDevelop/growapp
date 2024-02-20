import 'package:grow_tokyo_app/screens/product/model/product_list_response.dart';

class WishListResponse {
  String? message;
  bool? status;
  ProductData? wishlist;

  WishListResponse({this.message, this.status, this.wishlist});

  factory WishListResponse.fromJson(Map<String, dynamic> json) {
    return WishListResponse(
      message: json['message'],
      status: json['status'],
      wishlist: json['wishlist'] != null
          ? ProductData.fromJson(json['wishlist'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (wishlist != null) {
      data['wishlist'] = wishlist!.toJson();
    }
    return data;
  }
}
