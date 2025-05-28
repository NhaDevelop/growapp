import 'cart_list_response.dart';

class CartResponse {
  CartListData? cart;
  String? message;
  bool? status;

  CartResponse({this.cart, this.message, this.status});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      cart: json['cart'] != null ? CartListData.fromJson(json['cart']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    return data;
  }
}
