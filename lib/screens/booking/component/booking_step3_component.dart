import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/slot_widget.dart';
import 'package:grow_tokyo_app/components/view_all_label_component.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/booking/view/confirm_booking_screen.dart';
import 'package:grow_tokyo_app/screens/experts/component/employee_calendar_component.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_month_schedule_response.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/extensions/date_extensions.dart';
import 'package:grow_tokyo_app/utils/extensions/int_extension.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_bottom_price_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../utils/app_common.dart';
import '../../branch/branch_repository.dart';
import '../../branch/model/branch_configuration_response.dart';
import '../../services/models/service_response.dart';
import '../booking_repository.dart';
import '../shimmer/booking_step3_shimmer.dart';

class BookingStep3Component extends StatefulWidget {
  final bool isFromBookingInfoDetail;
  final bool isReschedule;
  final int? bookingId;
  final int? employeeId;
  final List<ServiceListData>? serviceList;

  const BookingStep3Component(
      {super.key,
      this.isFromBookingInfoDetail = false,
      this.bookingId,
      this.serviceList,
      this.employeeId,
      this.isReschedule = false});

  @override
  State<BookingStep3Component> createState() => _BookingStep3ComponentState();
}

class _BookingStep3ComponentState extends State<BookingStep3Component> {
  UniqueKey slotWidgetKey = UniqueKey();

  Future<BranchConfigurationData?>? future;

  DateTime? selectedDate;
  List<EmployeeWorkingDayModel> employeeSchedule = [];

  List<String> monthList =
      List.generate(12, (index) => (index + 1).toMonthName());
  int currentMonthNumber = DateTime.now().month;
  int selectedMonthIndex = DateTime.now().month - 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = getBranchConfiguration(
        appStore.branchId, bookingRequestStore.employeeId);
  }

  SlotData? getBranchSlotOnDate(List<SlotData>? slot, DateTime date) {
    if (slot
        .validate()
        .any((element) => element.day == date.weekday.getWeekDayName)) {
      return slot
          .validate()
          .firstWhere((element) => element.day == date.weekday.getWeekDayName);
    }

    return null;
  }

  String getSlotStartTime(List<SlotData>? slot, DateTime date) {
    final index = employeeSchedule
        .indexWhere((element) => element.date.isSameDateWith(date));
    final branchSlot = getBranchSlotOnDate(slot, date);

    if (branchSlot == null) return DEFAULT_SLOT_INTERVAL_DURATION;

    return index < 0
        ? branchSlot.startTime.validate()
        : branchSlot
            .getStartTimeWithEmployeeStartHour(
                employeeSchedule[index].startingHour)
            .validate();
  }

  String getSlotEndTime(List<SlotData>? slot, DateTime date) {
    final index = employeeSchedule
        .indexWhere((element) => element.date.isSameDateWith(date));
    final branchSlot = getBranchSlotOnDate(slot, date);

    if (branchSlot == null) return DEFAULT_SLOT_INTERVAL_DURATION;

    return index < 0
        ? branchSlot.endTime.validate()
        : branchSlot
            .getEndTimeWithEmployeeEndHour(employeeSchedule[index].endingHour)
            .validate();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: widget.isFromBookingInfoDetail ? true : false,
      appBarWidget: commonAppBarWidget(
        context,
        title: '${locale.date} & ${locale.time}',
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Stack(
            children: [
              AnimatedScrollView(
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: widget.isFromBookingInfoDetail ? 10 : 50,
                    bottom: widget.isFromBookingInfoDetail ? 60 : 80),
                onSwipeRefresh: () async {
                  init();
                  setState(() {});

                  return await 2.seconds.delay;
                },
                children: [
                  ViewAllLabel(label: locale.date, isShowAll: false),
                  Container(
                    decoration: boxDecorationWithRoundedCorners(),
                    child: EmployeeCalendarComponent(
                      employeeId: bookingRequestStore.employeeId,
                      branchId: appStore.branchId,
                      onSelect: (day) {
                        selectedDate = day;
                        slotWidgetKey = UniqueKey();
                        setState(() {});
                      },
                      onEmployeeScheduleLoaded: (data) {
                        employeeSchedule = data;
                        setState(() {});
                      },
                    ).paddingAll(12),
                  ),
                  8.height,
                  ViewAllLabel(label: locale.availableSlots, isShowAll: false),
                  SnapHelperWidget(
                    future: future,
                    loadingWidget: const BookingStep3Shimmer(),
                    initialData: branchConfigurationCached,
                    errorBuilder: (error) {
                      return NoDataWidget(
                        title: error,
                        retryText: locale.reload,
                        imageWidget: const ErrorStateWidget(),
                        onRetry: () {
                          appStore.setLoading(true);

                          init();
                          setState(() {});
                        },
                      );
                    },
                    onSuccess: (snap) {
                      if (selectedDate == null) {
                        return NoDataWidget(
                          title: locale.pleaseSelectDateFirst,
                        );
                      }
                      if (snap == null) {
                        return NoDataWidget(
                          title: locale.noTimeSlots,
                          retryText: locale.reload,
                          onRetry: () {
                            appStore.setLoading(true);

                            init();
                            setState(() {});
                          },
                        );
                      }

                      return SlotWidget(
                        key: slotWidgetKey,
                        selectedHorizontalDate: selectedDate!,
                        startTime: getSlotStartTime(snap.slot, selectedDate!),
                        endTime: getSlotEndTime(snap.slot, selectedDate!),
                        slotDuration: snap.slotDuration
                            .validate(value: DEFAULT_SLOT_INTERVAL_DURATION),
                      );
                    },
                  ),
                ],
              ),
              Observer(
                  builder: (context) =>
                      const LoaderWidget().visible(appStore.isLoading)),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Observer(
              builder: (_) => CommonBottomPriceWidget(
                title: bookingRequestStore.employeeName,
                subtitle: bookingRequestStore.selectedServiceList
                    .map((e) => widget.isReschedule
                        ? e.serviceName.validate()
                        : e.name.validate())
                    .toList()
                    .join(', '),
                buttonText: locale.confirm,
                onTap: () async {
                  if (selectedDate == null) {
                    toast(locale.pleaseSelectDateFirst);
                    return;
                  }
                  if (bookingRequestStore.time.isNotEmpty) {
                    bookingRequestStore.setDateInRequest(selectedDate!
                        .setFormattedDate(DateFormatConst.DATE_FORMAT_5)
                        .toString());

                    /// Slot Verify API Call
                    doIfLoggedIn(context, () async {
                      appStore.setLoading(true);

                      await verifySlot(bookingRequestStore.employeeId,
                              '${bookingRequestStore.date} ${bookingRequestStore.time}:00')
                          .then((value) {
                        ConfirmBookingScreen(isReschedule: widget.isReschedule)
                            .launch(context);
                      }).catchError((e) {
                        toast(e.toString());
                      });
                      appStore.setLoading(false);
                    });
                  } else {
                    toast(locale.pleaseSelectTimeSlotFirst);
                  }
                },
              ),
            ),
          ).visible(!widget.isFromBookingInfoDetail),
        ],
      ),
    );
  }
}
