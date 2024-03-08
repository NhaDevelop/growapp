import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/common_app_dialog.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/payment/payment_repo.dart';
import 'package:grow_tokyo_app/screens/booking/booking_repository.dart';
import 'package:grow_tokyo_app/screens/dashboard/view/dashboard_screen.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key, required this.isReschedule});

  final bool isReschedule;

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  void saveBooking() {
    if (bookingRequestStore.bookingId == null) {
      appStore.setLoading(true);
      final tempDate = bookingRequestStore.date.validate();
      final tempTime = bookingRequestStore.time.validate();

      final dateString = "$tempDate $tempTime";
      final initialDateTime = DateTime.parse(dateString);

      try {
        bookingRequestStore.selectedServiceList
            .validate()
            .forEachIndexed((element, index) {
          if (index == 0) {
            element.startDateTime = formatDate(initialDateTime.toString(),
                format: DateFormatConst.NEW_FORMAT);
            element.previousTime = initialDateTime;
          } else {
            ServiceListData previousData =
                bookingRequestStore.selectedServiceList.validate()[index - 1];
            element.startDateTime = formatDate(
                previousData.previousTime!
                    .add(previousData.durationMin.minutes)
                    .toString(),
                format: DateFormatConst.NEW_FORMAT);
            element.previousTime = previousData.previousTime!
                .add(previousData.durationMin.minutes);
          }
        });
      } catch (e) {
        appStore.setLoading(false);
        return toast(e.toString());
      }

      /// Save Booking API
      saveBookingAPI(bookingRequestStore.toJson(
              dateTime: formatDate(initialDateTime.toString(),
                  format: DateFormatConst.NEW_FORMAT),
              isRescheduleBooking: widget.isReschedule))
          .then((value) async {
        appStore.setLoading(false);
        bookingRequestStore.setBookingIdInRequest(value[CommonKey.bookingId]);

        savePayment(bookingId: bookingRequestStore.bookingId.validate())
            .then((value) {
          finish(context);
          finish(context);
          showBookingCompleteDialog();
        }).catchError((e) {
          toast(e.toString());
        });
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);
      });
    } else {
      savePayment(bookingId: bookingRequestStore.bookingId.validate());
    }
  }

  Future<void> savePayment({required int bookingId}) async {
    await savePay(
      bookingId: bookingId,
      externalTransactionId: '',
      transactionType: PaymentMethods.PAYMENT_METHOD_CASH,
      discountPercentage: 0,
      discountAmount: 0,
      taxData: bookingRequestStore.taxPercentage.validate(),
      paymentStatus: '0',
      totalAmount: bookingRequestStore.totalAmount,
    );
  }

  void showBookingCompleteDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) => CommonAppDialog(
        title: locale.bookingSuccessful,
        subTitle:
            '${locale.yourBookingFor} ${bookingRequestStore.selectedServiceList.validate().map((e) => e.name.validate()).toList().join(', ')} has been successfully booked',
        buttonText: locale.goToBookings,
        onTap: () {
          finish(context);
          const DashboardScreen(pageIndex: 1).launch(context, isNewTask: true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.confirmBooking,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.yourInformation, style: secondaryTextStyle()),
                12.height,
                _Card(
                  child: Column(
                    children: [
                      _RowData(
                          title: locale.name, value: userStore.userFullName),
                      8.height,
                      _RowData(
                        title: locale.contactNumber,
                        value: userStore.userContactNumber,
                      ),
                    ],
                  ),
                ),
                16.height,
                Text(locale.timeSlot, style: secondaryTextStyle()),
                12.height,
                _Card(
                  child: _RowData(
                    title: '${locale.date} & ${locale.time}',
                    value:
                        '${bookingRequestStore.date.validate()} at ${bookingRequestStore.time.validate()}',
                  ),
                ),
                16.height,
                Text(locale.stylist, style: secondaryTextStyle()),
                12.height,
                _Card(
                  child: _RowData(
                    title: locale.stylist,
                    value: bookingRequestStore.employeeName.validate(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: primaryColor,
                borderRadius:
                    radiusOnly(topLeft: defaultRadius, topRight: defaultRadius),
              ),
              child: AppButton(
                text: locale.bookNow,
                textStyle: boldTextStyle(color: primaryColor),
                onTap: saveBooking,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        backgroundColor: Colors.white,
      ),
      child: child.paddingAll(16),
    );
  }
}

class _RowData extends StatelessWidget {
  final String title;
  final String value;

  const _RowData({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: secondaryTextStyle()),
        Text(value, style: boldTextStyle()),
      ],
    );
  }
}
