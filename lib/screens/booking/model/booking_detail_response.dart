import 'package:grow_tokyo_app/screens/booking/model/booking_list_response.dart';

class BookingDetailResponse {
  BookingListData? data;
  String? message;
  bool? status;

  BookingDetailResponse({this.data, this.message, this.status});

  factory BookingDetailResponse.fromJson(Map<String, dynamic> json) {
    return BookingDetailResponse(
      data:
          json['data'] != null ? BookingListData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }
}

class Payment {
  int? bookingId;
  String? createdAt;
  int? createdBy;
  String? createdGuard;
  String? deletedAt;
  int? deletedBy;
  String? deletedGuard;
  num? discountAmount;
  num? discountPercentage;
  String? externalTransactionId;
  int? id;
  int? paymentStatus;
  String? requestToken;
  List<TaxPercentage>? taxPercentage;
  int? tipAmount;
  String? transactionType;
  String? updatedAt;
  int? updatedBy;
  String? updatedGuard;

  Payment({
    this.bookingId,
    this.createdAt,
    this.createdBy,
    this.createdGuard,
    this.deletedAt,
    this.deletedBy,
    this.deletedGuard,
    this.discountAmount,
    this.discountPercentage,
    this.externalTransactionId,
    this.id,
    this.paymentStatus,
    this.requestToken,
    this.taxPercentage,
    this.tipAmount,
    this.transactionType,
    this.updatedAt,
    this.updatedBy,
    this.updatedGuard,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      bookingId: json['booking_id'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      createdGuard: json['created_guard'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      deletedGuard: json['deleted_guard'],
      discountAmount: json['discount_amount'],
      discountPercentage: json['discount_percentage'],
      externalTransactionId: json['external_transaction_id'],
      id: json['id'],
      paymentStatus: json['payment_status'],
      requestToken: json['request_token'],
      taxPercentage: json['tax_percentage'] != null
          ? (json['tax_percentage'] as List)
              .map((i) => TaxPercentage.fromJson(i))
              .toList()
          : null,
      tipAmount: json['tip_amount'],
      transactionType: json['transaction_type'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      updatedGuard: json['updated_guard'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['created_at'] = createdAt;
    data['created_guard'] = createdGuard;
    data['deleted_guard'] = deletedGuard;
    data['discount_amount'] = discountAmount;
    data['discount_percentage'] = discountPercentage;
    data['external_transaction_id'] = externalTransactionId;
    data['id'] = id;
    data['payment_status'] = paymentStatus;
    data['tip_amount'] = tipAmount;
    data['transaction_type'] = transactionType;
    data['updated_at'] = updatedAt;
    data['updated_guard'] = updatedGuard;
    if (createdBy != null) {
      data['created_by'] = createdBy;
    }
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    if (deletedBy != null) {
      data['deleted_by'] = deletedBy;
    }
    if (requestToken != null) {
      data['request_token'] = requestToken;
    }
    if (taxPercentage != null) {
      data['tax_percentage'] = taxPercentage!.map((v) => v.toJson()).toList();
    }
    if (updatedBy != null) {
      data['updated_by'] = updatedBy;
    }
    return data;
  }
}

class TaxPercentage {
  String? name;
  int? id;
  int? percent;
  int? taxAmount;
  String? type;

  TaxPercentage({this.id, this.name, this.percent, this.taxAmount, this.type});

  factory TaxPercentage.fromJson(Map<String, dynamic> json) {
    return TaxPercentage(
      id: json['id'],
      name: json['name'],
      percent: json['percent'],
      taxAmount: json['tax_amount'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['percent'] = percent;
    data['tax_amount'] = taxAmount;
    data['type'] = type;
    return data;
  }
}

class ProductsInfo {
  int? bookingId;
  String? discountType;
  num? discountValue;
  num? discountedPrice;
  int? employeeId;
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  num? productPrice;
  int? productQty;
  int? productVariationId;
  String? variationName;
  String? productImage;

  ProductsInfo({
    this.bookingId,
    this.discountType,
    this.discountValue,
    this.discountedPrice,
    this.employeeId,
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.productPrice,
    this.productQty,
    this.productVariationId,
    this.variationName,
    this.productImage,
  });

  factory ProductsInfo.fromJson(Map<String, dynamic> json) {
    return ProductsInfo(
      bookingId: json['booking_id'],
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
      discountedPrice: json['discounted_price'],
      employeeId: json['employee_id'],
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      productQty: json['product_qty'],
      productVariationId: json['product_variation_id'],
      variationName: json['variation_name'],
      productImage: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['discount_type'] = discountType;
    data['discount_value'] = discountValue;
    data['discounted_price'] = discountedPrice;
    data['employee_id'] = employeeId;
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['product_qty'] = productQty;
    data['product_variation_id'] = productVariationId;
    data['variation_name'] = variationName;
    data['product_image'] = productImage;
    return data;
  }
}
