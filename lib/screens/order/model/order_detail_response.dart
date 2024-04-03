import 'package:nb_utils/nb_utils.dart';

import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../cart/model/cart_list_response.dart';

class OrderDetailResponse {
  OrderListData? data;
  String? message;
  bool? status;

  OrderDetailResponse({this.data, this.message, this.status});

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponse(
      data: json['data'] != null ? OrderListData.fromJson(json['data']) : null,
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

class OrderListData {
  String? addressLine1;
  String? addressLine2;
  String? alternativePhoneNo;
  String? city;
  String? country;
  String? deliveryStatus;
  int? id;
  String? orderCode;
  String? logisticName;
  String? paymentStatus;
  String? phoneNo;
  String? postalCode;
  List<CartListData>? productDetails;
  String? state;
  num? totalAmount;
  int? userId;
  String? userName;
  String? orderDate;
  String? expectedDeliveryDate;
  String? deliveryDays;
  num? logisticCharge;
  String? deliveryTime;
  String? paymentMethod;
  num? subTotalAmount;
  num? totalTaxAmount;

  // local
  DateTime get orderingDateTime =>
      DateTime.parse(orderDate.validate()).toLocal();
  DateTime? get deliveringDateTime =>
      DateTime.tryParse(expectedDeliveryDate.validate())?.toLocal();

  String get orderingDate => formatDate(orderingDateTime.toString(),
      format: DateFormatConst.BOOK_DATE_FORMAT);
  String get deliveringDate => deliveringDateTime != null
      ? formatDate(deliveringDateTime.toString(),
          format: DateFormatConst.BOOK_DATE_FORMAT)
      : '';

  OrderListData({
    this.addressLine1,
    this.addressLine2,
    this.alternativePhoneNo,
    this.city,
    this.country,
    this.deliveryStatus,
    this.id,
    this.orderCode,
    this.logisticName,
    this.paymentStatus,
    this.phoneNo,
    this.postalCode,
    this.productDetails,
    this.state,
    this.totalAmount,
    this.userId,
    this.userName,
    this.orderDate,
    this.expectedDeliveryDate,
    this.deliveryDays,
    this.deliveryTime,
    this.logisticCharge,
    this.subTotalAmount,
    this.paymentMethod,
    this.totalTaxAmount,
  });

  factory OrderListData.fromJson(Map<String, dynamic> json) {
    return OrderListData(
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      alternativePhoneNo: json['alternative_phone_no'],
      city: json['city'],
      country: json['country'],
      deliveryStatus: json['delivery_status'],
      id: json['id'],
      orderCode: json['order_code'],
      logisticName: json['logistic_name'],
      paymentStatus: json['payment_status'],
      phoneNo: json['phone_no'],
      postalCode: json['postal_code'],
      productDetails: json['product_details'] != null
          ? (json['product_details'] as List)
              .map((i) => CartListData.fromJson(i))
              .toList()
          : null,
      state: json['state'],
      totalAmount: json['total_amount'],
      userId: json['user_id'],
      userName: json['user_name'],
      orderDate: json['order_date'],
      expectedDeliveryDate: json['expected_delivery_date'],
      deliveryDays: json['delivery_days'],
      deliveryTime: json['delivery_time'],
      logisticCharge: json['logistic_charge'],
      paymentMethod: json['payment_method'],
      subTotalAmount: json['sub_total_amount'],
      totalTaxAmount: json['total_tax_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    data['city'] = city;
    data['country'] = country;
    data['delivery_status'] = deliveryStatus;
    data['id'] = id;
    data['order_code'] = orderCode;
    data['logistic_name'] = logisticName;
    data['payment_status'] = paymentStatus;
    data['postal_code'] = postalCode;
    data['state'] = state;
    data['total_amount'] = totalAmount;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['order_date'] = orderDate;
    data['expected_delivery_date'] = expectedDeliveryDate;
    data['delivery_days'] = deliveryDays;
    data['delivery_time'] = deliveryTime;
    data['logistic_charge'] = logisticCharge;
    data['payment_method'] = paymentMethod;
    data['sub_total_amount'] = subTotalAmount;
    data['total_tax_amount'] = totalTaxAmount;
    if (alternativePhoneNo != null) {
      data['alternative_phone_no'] = alternativePhoneNo;
    }
    if (phoneNo != null) {
      data['phone_no'] = phoneNo;
    }
    if (productDetails != null) {
      data['product_details'] = productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
