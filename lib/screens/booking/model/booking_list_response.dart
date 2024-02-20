import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/review_data.dart';
import '../../../utils/common_base.dart';
import '../../cart/model/cart_list_response.dart';
import 'booking_detail_response.dart';

class BookingListResponse {
  List<BookingListData>? data;
  String? message;
  bool? status;

  BookingListResponse({this.data, this.message, this.status});

  factory BookingListResponse.fromJson(Map<String, dynamic> json) {
    return BookingListResponse(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => BookingListData.fromJson(i))
              .toList()
          : null,
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

class BookingListData {
  String? branchName;
  String? createdAt;
  String? createdByName;
  String? employeeName;
  String? employeeImage;
  int? id;
  String? note;
  String? startDateTime;
  String? status;
  String? updatedAt;
  String? updatedByName;
  String? userCreated;
  String? userName;
  String? userProfileImage;

  String? addressLine1;
  String? addressLine2;
  int? branchId;
  int? employeeId;
  String? phone;
  int? userId;
  ReviewData? customerReview;
  List<ServiceListData>? serviceList;
  num? discount;
  num? tip;
  Payment? payment;

  List<ProductsInfo>? productsInfo;
  num? discoutAmount;
  num? sumOfServicePrices;
  num? sumOfProductPrices;
  num? taxAmount;
  num? totalAmount;
  List<TaxDetail>? taxDetails;

  // local
  DateTime get bookingDateTime => DateTime.parse(startDateTime.validate());

  String get bookingDate => formatDate(bookingDateTime.toString(),
      format: DateFormatConst.BOOK_DATE_FORMAT);

  String get bookingTime => formatDate(bookingDateTime.toString(),
      format: DateFormatConst.HOUR_12_FORMAT);

  String get statusLabel => status.validate().getBookingStatusLabel;

  // Local Variable for booking the appointment
  String? date;
  String? time;
  List<ServiceListData>? selectedServiceList;

  BookingListData({
    this.branchName,
    this.createdAt,
    this.createdByName,
    this.employeeName,
    this.employeeImage,
    this.id,
    this.note,
    this.startDateTime,
    this.status,
    this.updatedAt,
    this.updatedByName,
    this.userCreated,
    this.userName,
    this.userProfileImage,
    this.addressLine1,
    this.addressLine2,
    this.branchId,
    this.employeeId,
    this.phone,
    this.userId,
    this.customerReview,
    this.discount,
    this.tip,
    this.payment,
    this.serviceList,
    this.productsInfo,
    this.discoutAmount,
    this.sumOfServicePrices,
    this.sumOfProductPrices,
    this.taxAmount,
    this.totalAmount,
    this.taxDetails,
  });

  factory BookingListData.fromJson(Map<String, dynamic> json) {
    return BookingListData(
      branchName: json['branch_name'],
      createdAt: json['created_at'],
      createdByName: json['created_by_name'],
      employeeName: json['employee_name'],
      employeeImage: json['employee_image'],
      id: json['id'],
      note: json['note'],
      startDateTime: json['start_date_time'],
      status: json['status'],
      updatedAt: json['updated_at'],
      updatedByName: json['updated_by_name'],
      userCreated: json['user_created'],
      userName: json['user_name'],
      userProfileImage: json['user_profile_image'],
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      branchId: json['branch_id'],
      employeeId: json['employee_id'],
      phone: json['phone'],
      userId: json['user_id'],
      customerReview: json['customer_review'] != null
          ? ReviewData.fromJson(json['customer_review'])
          : null,
      discount: json['discount'],
      tip: json['tip'],
      payment:
          json['payment'] != null ? Payment.fromJson(json['payment']) : null,
      serviceList: json['services'] != null
          ? (json['services'] as List)
              .map((i) => ServiceListData.fromJson(i))
              .toList()
          : null,
      productsInfo: json['products'] != null
          ? (json['products'] as List)
              .map((i) => ProductsInfo.fromJson(i))
              .toList()
          : null,
      sumOfServicePrices: json['sumOfServicePrices'],
      sumOfProductPrices: json['sumOfProductPrices'],
      discoutAmount: json['discout_amount'],
      taxAmount: json['tax_amount'],
      totalAmount: json['total_amount'],
      taxDetails: json['tax_details'] != null
          ? (json['tax_details'] as List)
              .map((i) => TaxDetail.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_name'] = branchName;
    data['created_at'] = createdAt;
    data['created_by_name'] = createdByName;
    data['employee_image'] = employeeImage;
    data['id'] = id;
    data['start_date_time'] = startDateTime;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['updated_by_name'] = updatedByName;
    data['user_created'] = userCreated;
    data['user_name'] = userName;
    data['user_profile_image'] = userProfileImage;
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    data['branch_id'] = branchId;
    data['employee_id'] = employeeId;
    data['phone'] = phone;
    data['user_id'] = userId;
    data['discount'] = discount;
    data['tip'] = tip;
    data['sumOfServicePrices'] = sumOfServicePrices;
    data['sumOfProductPrices'] = sumOfProductPrices;
    data['discout_amount'] = discoutAmount;
    data['tax_amount'] = taxAmount;
    data['total_amount'] = totalAmount;
    if (note != null) {
      data['note'] = note;
    }
    if (customerReview != null) {
      data['customer_review'] = customerReview!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    if (serviceList != null) {
      data['services'] = serviceList!.map((v) => v.toJson()).toList();
    }
    if (productsInfo != null) {
      data['products'] = productsInfo!.map((v) => v.toJson()).toList();
    }
    if (taxDetails != null) {
      data['tax_data'] = taxDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// For Save Booking
  Map<String, dynamic> toBookingJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeId != null) data['employee_id'] = employeeId;
    if (date != null) data['date'] = date;
    if (time != null) data['time'] = time.validate();
    data['branch_id'] = appStore.branchId;

    if (selectedServiceList != null) {
      data['services'] = selectedServiceList
          .validate()
          .map((e) => e.toBookingServiceJson())
          .toList();
    }

    return data;
  }
}
