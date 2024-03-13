import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/slot_widget.dart';
import 'package:grow_tokyo_app/components/view_all_label_component.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/booking/view/confirm_booking_screen.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/extensions/date_extensions.dart';
import 'package:grow_tokyo_app/utils/extensions/int_extension.dart';
import 'package:grow_tokyo_app/utils/horizontalCalender/date_item.dart';
import 'package:grow_tokyo_app/utils/horizontalCalender/date_picker_controller.dart';
import 'package:grow_tokyo_app/utils/horizontalCalender/horizontal_date_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_bottom_price_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../utils/app_common.dart';
import '../../branch/branch_repository.dart';
import '../../branch/model/branch_configuration_response.dart';
// import '../../dashboard/component/booking_list_component.dart';
import '../../services/models/service_response.dart';
import '../booking_repository.dart';
import '../shimmer/booking_step3_shimmer.dart';
// import '../view/booking_detail_screen.dart';

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
  final DatePickerController _datePickerController = DatePickerController();
  UniqueKey slotWidgetKey = UniqueKey();

  Future<BranchConfigurationResponse>? future;

  DateTime? selectedHorizontalDate;

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

  void setCustomDate(int month) {
    selectedHorizontalDate = DateTime(DateTime.now().year, month, 1);
    _datePickerController.selectedDate = selectedHorizontalDate;
    _datePickerController.scrollTo(selectedHorizontalDate!);

    _datePickerController.scrollToSelectedItem();
    setState(() {});
  }

  String getSlotStartTime(List<SlotData>? slot, DateTime date) {
    if (slot
        .validate()
        .any((element) => element.day == date.weekday.getWeekDayName)) {
      return slot
          .validate()
          .firstWhere((element) => element.day == date.weekday.getWeekDayName)
          .startTime
          .validate();
    }

    return DEFAULT_SLOT_INTERVAL_DURATION;
  }

  String getSlotEndTime(List<SlotData>? slot, DateTime date) {
    if (slot
        .validate()
        .any((element) => element.day == date.weekday.getWeekDayName)) {
      return slot
          .validate()
          .firstWhere((element) => element.day == date.weekday.getWeekDayName)
          .endTime
          .validate();
    }

    return DEFAULT_SLOT_INTERVAL_DURATION;
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
              SnapHelperWidget(
                future: future,
                loadingWidget: BookingStep3Shimmer(
                    isFromBookingInfoDetail: widget.isFromBookingInfoDetail),
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
                  if (snap.data == null) {
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

                  if (selectedHorizontalDate == null &&
                      snap.data!.employeeSchedule.isNotEmpty) {
                    selectedHorizontalDate = snap.data!.employeeSchedule.first;
                  }

                  return AnimatedScrollView(
                    padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: widget.isFromBookingInfoDetail ? 10 : 60,
                        bottom: widget.isFromBookingInfoDetail ? 60 : 80),
                    onSwipeRefresh: () async {
                      init();
                      setState(() {});

                      return await 2.seconds.delay;
                    },
                    children: [
                      ViewAllLabel(label: locale.date, isShowAll: false),
                      8.height,
                      Container(
                        decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: context.cardColor,
                            borderRadius: radius()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SettingItemWidget(
                              title:
                                  '${monthList[selectedMonthIndex]} ${DateTime.now().year}',
                              titleTextStyle: boldTextStyle(
                                  size: 14, color: textSecondaryColorGlobal),
                              padding: EdgeInsets.zero,
                              trailing: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (selectedMonthIndex <
                                          currentMonthNumber) {
                                        //
                                      } else {
                                        selectedMonthIndex--;
                                        setCustomDate(currentMonthNumber - 1);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: ICON_SIZE,
                                      color: selectedMonthIndex <
                                              currentMonthNumber
                                          ? grey
                                          : context.iconColor,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (selectedMonthIndex == 11) {
                                          //
                                        } else {
                                          selectedMonthIndex++;
                                          setCustomDate(currentMonthNumber + 1);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: ICON_SIZE,
                                        color: selectedMonthIndex == 11
                                            ? grey
                                            : context.iconColor,
                                      )),
                                ],
                              ),
                            ).paddingOnly(left: 16),
                            Divider(height: 0, color: context.dividerColor),
                            HorizontalDatePickerWidget(
                              enableDayPredicate: (date) =>
                                  date.isInList(snap.data!.employeeSchedule),
                              datePickerController: _datePickerController,
                              height: 70,
                              startDate: DateTime.now(),
                              endDate: DateTime(DateTime.now().year,
                                  DateTime.now().month + 1),
                              selectedDate: selectedHorizontalDate,
                              widgetWidth: context.width(),
                              selectedColor: indicatorColor,
                              selectedTextColor: Colors.white,
                              dateItemComponentList: const [
                                DateItem.Month,
                                DateItem.WeekDay,
                                DateItem.Day
                              ],
                              dayFontSize: 14,
                              weekDayFontSize: 14,
                              onValueSelected: (date) {
                                selectedHorizontalDate = date;
                                log(selectedHorizontalDate);

                                slotWidgetKey = UniqueKey();
                                setState(() {});
                              },
                            ).paddingSymmetric(vertical: 16),
                          ],
                        ),
                      ),
                      if (selectedHorizontalDate != null) ...[
                        16.height,
                        ViewAllLabel(
                            label: locale.availableSlots, isShowAll: false),
                        8.height,
                        SlotWidget(
                          key: slotWidgetKey,
                          selectedHorizontalDate: selectedHorizontalDate!,
                          startTime: getSlotStartTime(
                              snap.data!.slot, selectedHorizontalDate!),
                          endTime: getSlotEndTime(
                              snap.data!.slot, selectedHorizontalDate!),
                          slotDuration: snap.data!.slotDuration
                              .validate(value: DEFAULT_SLOT_INTERVAL_DURATION),
                        ),
                      ],
                    ],
                  );
                },
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
                  if (selectedHorizontalDate == null) {
                    toast(locale.pleaseSelectDateFirst);
                    return;
                  }
                  if (bookingRequestStore.time.isNotEmpty) {
                    bookingRequestStore.setDateInRequest(selectedHorizontalDate!
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
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: secondaryColor,
      //   onPressed: () {
      //     showConfirmDialogCustom(
      //       context,
      //       title: locale.bookingTimeSlotChangeMessage,
      //       positiveText: locale.yes,
      //       negativeText: locale.no,
      //       onAccept: (_) {
      //         List<ServiceListData> selectedService = [];

      //         bookingRequestStore
      //             .setEmployeeIdInRequest(widget.employeeId.validate());
      //         bookingRequestStore.setDateInRequest(selectedHorizontalDate
      //             .setFormattedDate(DateFormatConst.DATE_FORMAT_5)
      //             .toString());

      //         widget.serviceList.validate().forEachIndexed((element, index) {
      //           selectedService.add(widget.serviceList.validate()[index]);
      //         });

      //         bookingRequestStore
      //             .setSelectedServiceListInRequest(selectedService);

      //         String tempDate = bookingRequestStore.date.validate();
      //         String tempTime = bookingRequestStore.time.validate();

      //         String dateString = "$tempDate $tempTime";

      //         DateTime initialDateTime = DateTime.parse(dateString);

      //         String updatedDateTime = formatDate(initialDateTime.toString(),
      //             format: DateFormatConst.NEW_FORMAT);

      //         bookingRequestStore.selectedServiceList
      //             .validate()
      //             .forEachIndexed((element, index) {
      //           if (index == 0) {
      //             element.startDateTime = formatDate(initialDateTime.toString(),
      //                 format: DateFormatConst.NEW_FORMAT);
      //             element.previousTime = initialDateTime;
      //           } else {
      //             ServiceListData previousData = bookingRequestStore
      //                 .selectedServiceList
      //                 .validate()[index - 1];
      //             element.startDateTime = formatDate(
      //                 previousData.previousTime!
      //                     .add(previousData.durationMin.minutes)
      //                     .toString(),
      //                 format: DateFormatConst.NEW_FORMAT);
      //             element.previousTime = previousData.previousTime!
      //                 .add(previousData.durationMin.minutes);
      //           }
      //         });

      //         appStore.setLoading(true);

      //         bookingUpdate(bookingRequestStore.toJson(
      //                 dateTime: updatedDateTime,
      //                 bookingId: widget.bookingId,
      //                 bookingStatus: BookingStatusConst.PENDING,
      //                 isUpdate: true))
      //             .then((value) {
      //           appStore.setLoading(false);

      //           onBookingDetailUpdate.call();
      //           onBookingListUpdate.call('');
      //           finish(context);
      //           toast(locale.bookingSuccessfullyUpdateMessage);
      //         }).catchError((e) {
      //           appStore.setLoading(false);
      //           toast(e.toString());
      //         });
      //       },
      //       primaryColor: context.primaryColor,
      //     );
      //   },
      //   label: Text(locale.update, style: boldTextStyle(color: Colors.white)),
      // ).visible(widget.isFromBookingInfoDetail),
    );
  }
}
