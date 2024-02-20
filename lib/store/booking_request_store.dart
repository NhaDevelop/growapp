import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../screens/booking/model/booking_detail_response.dart';
import '../screens/services/models/service_response.dart';
import '../utils/constants.dart';

part 'booking_request_store.g.dart';

class BookingRequestStore = _BookingRequestStore with _$BookingRequestStore;

abstract class _BookingRequestStore with Store {
  @observable
  int? bookingId;

  @observable
  int employeeId = -1;

  @observable
  String time = '';

  @observable
  String date = '';

  @observable
  String note = '';

  @observable
  bool? isReschedule;

  @observable
  List<ServiceListData> selectedServiceList = ObservableList();

  @observable
  List<String> selectedBookingStatusList = ObservableList();

  @observable
  List<TaxPercentage> taxPercentage = ObservableList();

  @observable
  num tipAmount = 0;

  @computed
  num get selectedServiceTotalAmount => selectedServiceList.validate().sumByDouble((p0) => isReschedule.validate() ? p0.servicePrice.validate() : p0.defaultPrice.validate());

  @computed
  double get fixedTaxAmount => taxPercentage.validate().where((element) => element.type == TaxType.FIXED).sumByDouble((p0) => p0.taxAmount.validate());

  @computed
  double get percentTaxAmount => taxPercentage.validate().where((element) => element.type == TaxType.PERCENT).sumByDouble((p0) => ((selectedServiceTotalAmount * p0.percent.validate()) / 100));

  @computed
  num get totalTax => fixedTaxAmount + percentTaxAmount;

  @computed
  num get totalAmount => selectedServiceTotalAmount + totalTax + tipAmount;

  Map<String, dynamic> toJson({String? dateTime, int? bookingId, String? bookingStatus, bool isUpdate = false, bool isRescheduleBooking = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (bookingId != null) data['id'] = bookingId;
    if (bookingStatus != null) data['status'] = bookingStatus;
    if (dateTime != null) data['start_date_time'] = dateTime;
    if (note.isNotEmpty) data['note'] = this.note.validate();
    data['branch_id'] = appStore.branchId;

    if (this.selectedServiceList.isNotEmpty) {
      data['services'] = this.selectedServiceList.validate().map((e) => e.toBookingServiceJson(isUpdate: isUpdate, isRescheduleBooking: isRescheduleBooking)).toList();
    }

    if (this.taxPercentage.isNotEmpty) {
      data['tax_percentage'] = this.taxPercentage.validate().map((e) => e.toJson()).toList();
    }

    return data;
  }

  @action
  void setTip(int val) {
    tipAmount = val;
  }

  @action
  void setBookingIdInRequest(int val) {
    bookingId = val;
  }

  @action
  void setEmployeeIdInRequest(int val) {
    employeeId = val;
  }

  @action
  void setTimeInRequest(String val) {
    time = val;
  }

  @action
  void setDateInRequest(String val) {
    date = val;
  }

  @action
  void setNoteInRequest(String val) {
    note = val;
  }

  @action
  void setSelectedServiceListInRequest(List<ServiceListData> selectedServiceListRequest, {bool isRescheduleInRequest = false}) {
    isReschedule = isRescheduleInRequest;

    selectedServiceList = ObservableList.of(selectedServiceListRequest);
  }

  @action
  void setSelectedBookingStatusList(List<String> selectedBookingStatusListRequest) {
    selectedBookingStatusList = ObservableList.of(selectedBookingStatusListRequest);
  }

  @action
  void setTaxPercentageInRequest(List<TaxPercentage> taxPercentageRequest) {
    taxPercentage = ObservableList.of(taxPercentageRequest);
  }
}
