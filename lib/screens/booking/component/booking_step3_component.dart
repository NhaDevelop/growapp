import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/slot_widget.dart';
import 'package:grow_tokyo_app/components/view_all_label_component.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/auth/view/sign_in_screen.dart';
import 'package:grow_tokyo_app/screens/booking/component/booking_type_selected_dialog.dart';
import 'package:grow_tokyo_app/screens/booking/shimmer/booking_step3_shimmer.dart';
import 'package:grow_tokyo_app/screens/booking/view/confirm_booking_screen.dart';
import 'package:grow_tokyo_app/screens/experts/component/employee_calendar_component.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_month_schedule_response.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/extensions/date_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_bottom_price_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../utils/app_common.dart';
import '../../branch/branch_repository.dart';
import '../../branch/model/branch_configuration_response.dart';
import '../../services/models/service_response.dart';
import '../booking_repository.dart';

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
  bool employeeScheduleLoaded = false;
  List<EmployeeWorkingDayModel> employeeSchedule = [];

  List<String> monthList = List.generate(12, (index) => (index + 1).toMonthName());
  int currentMonthNumber = DateTime.now().month;
  int selectedMonthIndex = DateTime.now().month - 1;

  EmployeeWorkingDayModel? get employeeScheduleOnSelectedDate {
    final index =
        employeeSchedule.indexWhere((element) => element.date.isSameDateWith(selectedDate));
    final schedule = index < 0 ? null : employeeSchedule[index];

    return schedule;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    future = getBranchConfiguration(appStore.branchId);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void onNextClicked() async {
    if (selectedDate == null) {
      return toast(locale.pleaseSelectDateFirst);
    }
    if (bookingRequestStore.time.isEmpty) {
      return toast(locale.pleaseSelectTimeSlotFirst);
    }

    bookingRequestStore
        .setDateInRequest(selectedDate!.setFormattedDate(DateFormatConst.DATE_FORMAT_5).toString());

    try {
      appStore.setLoading(true);
      if (bookingRequestStore.isEmployeeGroupSelected) {
        final employee = await verifyAnyStylistSlot(
          nationality: bookingRequestStore.employeeGroupId,
          branchId: appStore.branchId,
          servicesIds: bookingRequestStore.selectedServiceList.map((e) => e.id).toList(),
          startDateTime: bookingRequestStore.dateTime,
        );

        bookingRequestStore.setEmployeeIdInRequest(employee.id!);
        bookingRequestStore.setEmployeeNameInRequest(employee.fullName!);
      } else {
        await verifySlot(
          bookingRequestStore.employeeId,
          bookingRequestStore.dateTime,
        );
      }

      _confirmBooking();
    } catch (e) {
      toast(e.toString());
    } finally {
      appStore.setLoading(false);
    }
  }

  Future<void> _confirmBooking() async {
    if (appStore.isLoggedIn) {
      await ConfirmBookingScreen(isReschedule: widget.isReschedule).launch(context);
    } else {
      if (!mounted) return;
      final useGuestBooking = await showDialog<bool>(
        context: context,
        builder: (_) => const BookingTypeSelectedDialog(),
      );
      if (useGuestBooking == null) return;

      if (useGuestBooking) {
        if (!mounted) return;
        await ConfirmBookingScreen(isReschedule: widget.isReschedule, isGuestBooking: true)
            .launch(context);
      } else {
        if (!mounted) return;
        await const SignInScreen(
          returnExpected: true,
        ).launch(context);
      }
    }

    // Reset employee id and name if employee group is selected
    if (bookingRequestStore.isEmployeeGroupSelected) {
      bookingRequestStore.setEmployeeIdInRequest(UNSELECTED_EMPLOYEE_ID);
      bookingRequestStore.setEmployeeNameInRequest('');
    }
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
                        employeeScheduleLoaded = true;
                        employeeSchedule = data;
                        setState(() {});
                      },
                    ).paddingAll(12),
                  ),
                  8.height,
                  ViewAllLabel(label: locale.availableSlots, isShowAll: false),
                  !employeeScheduleLoaded
                      ? const BookingStep3Shimmer()
                      : employeeSchedule.isEmpty || employeeScheduleOnSelectedDate == null
                          ? NoDataWidget(title: locale.noTimeSlots)
                          : selectedDate == null
                              ? NoDataWidget(title: locale.pleaseSelectDateFirst)
                              : SnapHelperWidget(
                                  future: future,
                                  initialData: branchConfigurationCached,
                                  onSuccess: (snap) {
                                    return SlotWidget(
                                      key: slotWidgetKey,
                                      selectedHorizontalDate: selectedDate!,
                                      startTime: employeeScheduleOnSelectedDate!.startTime,
                                      endTime: employeeScheduleOnSelectedDate!.endTime,
                                      slotDuration:
                                          snap?.slotDuration ?? DEFAULT_SLOT_INTERVAL_DURATION,
                                      serviceList: widget.serviceList ?? [],
                                    );
                                  },
                                ),
                ],
              ),
              Observer(builder: (context) => const LoaderWidget().visible(appStore.isLoading)),
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
                    .map((e) => widget.isReschedule ? e.serviceName.validate() : e.name.validate())
                    .toList()
                    .join(', '),
                buttonText: locale.confirm,
                onTap: onNextClicked,
              ),
            ),
          ).visible(!widget.isFromBookingInfoDetail),
        ],
      ),
    );
  }
}
