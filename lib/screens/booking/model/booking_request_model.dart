import 'package:frezka/screens/booking/model/booking_detail_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../../utils/constants.dart';
import '../../services/models/service_response.dart';

class BookingRequestModel {
  int? bookingId;
  int? employeeId;
  String? time;
  String? date;
  String? note;
  List<ServiceListData>? selectedServiceList;
  List<TaxPercentage>? taxPercentage;

  //LOCAL
  num tipAmount;

  num get totalAmount => selectedServiceList.validate().sumByDouble((p0) => p0.defaultPrice.validate());

  double get fixedTaxAmount => taxPercentage.validate().where((element) => element.type == TaxType.FIXED).sumByDouble((p0) => (p0.taxAmount.validate()));

  double get percentTaxAmount => taxPercentage.validate().where((element) => element.type == TaxType.PERCENT).sumByDouble((p0) => ((totalAmount * p0.percent.validate()) / 100));

  num get totalTax => fixedTaxAmount + percentTaxAmount;

  num get calculateTotalAmount => totalAmount + totalTax + tipAmount;

  BookingRequestModel({
    this.bookingId,
    this.employeeId,
    this.time,
    this.date,
    this.note,
    this.selectedServiceList,
    this.taxPercentage,
    this.tipAmount = 0,
  });

  Map<String, dynamic> toJson({String? dateTime}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (dateTime != null) data['start_date_time'] = dateTime;
    if (note != null) data['note'] = this.note.validate();
    data['branch_id'] = appStore.branchId;

    if (this.selectedServiceList != null) {
      data['services'] = this.selectedServiceList.validate().map((e) => e.toBookingServiceJson()).toList();
    }

    if (this.taxPercentage != null) {
      data['tax_percentage'] = this.taxPercentage.validate().map((e) => e.toJson()).toList();
    }

    return data;
  }
}
