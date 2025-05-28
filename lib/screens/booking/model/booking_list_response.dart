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
          ? (json['data'] as List).map((i) => BookingListData.fromJson(i)).toList()
          : null,
      message: json['message'],
      status: json['status'],
    );
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
  num? referralRewardPercent;
  num? couponDiscountPercentage;
  num? amountPaidByCredit;
  num? sumOfServicePrices;
  num? sumOfProductPrices;
  num? taxAmount;
  num? totalAmount;
  List<TaxDetail>? taxDetails;

  // local
  DateTime get bookingDateTime => DateTime.parse(startDateTime.validate()).toLocal();

  String get bookingDate =>
      formatDate(bookingDateTime.toString(), format: DateFormatConst.BOOK_DATE_FORMAT);

  String get bookingTime =>
      formatDate(bookingDateTime.toString(), format: DateFormatConst.HOUR_24_FORMAT);

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
    this.amountPaidByCredit,
    this.referralRewardPercent,
    this.couponDiscountPercentage,
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
      customerReview:
          json['customer_review'] != null ? ReviewData.fromJson(json['customer_review']) : null,
      discount: json['discount'],
      tip: json['tip'],
      payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null,
      serviceList: json['services'] != null
          ? (json['services'] as List).map((i) => ServiceListData.fromJson(i)).toList()
          : null,
      productsInfo: json['products'] != null
          ? (json['products'] as List).map((i) => ProductsInfo.fromJson(i)).toList()
          : null,
      sumOfServicePrices: json['sumOfServicePrices'],
      sumOfProductPrices: json['sumOfProductPrices'],
      discoutAmount: json['discout_amount'],
      amountPaidByCredit: json['amount_paid_by_credit'],
      referralRewardPercent: json['referral_reward_percent'],
      couponDiscountPercentage: json['coupon_discount_percentage'],
      taxAmount: json['tax_amount'],
      totalAmount: json['total_amount'],
      taxDetails: json['tax_details'] != null
          ? (json['tax_details'] as List).map((i) => TaxDetail.fromJson(i)).toList()
          : null,
    );
  }

  /// For Save Booking
  Map<String, dynamic> toBookingJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeId != null) data['employee_id'] = employeeId;
    if (date != null) data['date'] = date;
    if (time != null) data['time'] = time.validate();
    data['branch_id'] = appStore.branchId;

    if (selectedServiceList != null) {
      data['services'] =
          selectedServiceList.validate().map((e) => e.toBookingServiceJson()).toList();
    }

    return data;
  }
}
