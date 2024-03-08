import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/components/common_app_dialog.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/payment/payment_repo.dart';
import 'package:grow_tokyo_app/screens/booking/booking_repository.dart';
import 'package:grow_tokyo_app/screens/booking/component/add_referral_code_modal.dart';
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
          SingleChildScrollView(
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
                16.height,
                Text(locale.services, style: secondaryTextStyle()),
                12.height,
                _Card(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookingRequestStore.selectedServiceList.length,
                    itemBuilder: (_, __) => const Divider(),
                    separatorBuilder: (_, index) {
                      final service =
                          bookingRequestStore.selectedServiceList[index];
                      return _ServiceItem(
                        key: ValueKey(service.id),
                        service: service,
                      );
                    },
                  ),
                ),
                12.height,
                AppTextField(
                  textFieldType: TextFieldType.MULTILINE,
                  decoration:
                      inputDecoration(context, hint: locale.serviceNote),
                  onChanged: bookingRequestStore.setNoteInRequest,
                ).cornerRadiusWithClipRRect(defaultRadius),
                16.height,
                Observer(builder: (context) {
                  return _Card(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: _CodeItem(
                      onTap: () {},
                      title: locale.coupon,
                      actionText: locale.addCoupon,
                      value: bookingRequestStore.couponCode,
                    ),
                  );
                }),
                16.height,
                Observer(builder: (context) {
                  return _Card(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: _CodeItem(
                      onTap: () => bookingRequestStore.referralCode != null
                          ? bookingRequestStore.setReferralCodeInRequest(null)
                          : showModalBottomSheet<String>(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) =>
                                  const AddReferralCodeModal(),
                            ).then(
                              bookingRequestStore.setReferralCodeInRequest),
                      title: locale.referralCode,
                      actionText: locale.addCode,
                      value: bookingRequestStore.referralCode,
                    ),
                  );
                }),
                16.height,
                _Card(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.usingXPoints(0), //TODO: Add user points
                            style: boldTextStyle(),
                          ),
                          4.height,
                          Text(
                            locale.youWillSave$X(0), //TODO: Add amount;
                            style: secondaryTextStyle(),
                          ),
                        ],
                      ).expand(),
                      Observer(builder: (_) {
                        return Switch.adaptive(
                          value: bookingRequestStore.useCredit,
                          onChanged: bookingRequestStore.setUseCreditInRequest,
                        );
                      })
                    ],
                  ),
                ),
                16.height,
                Text(locale.paymentDetails, style: secondaryTextStyle()),
                12.height,
                _Card(
                  child: _RowData(
                    title: locale.paymentMethod,
                    value: locale.payAtSalon,
                  ),
                ),
                80.height,
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
              ).paddingOnly(bottom: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  const _ServiceItem({
    super.key,
    required this.service,
  });

  final ServiceListData service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedImageWidget(
          url: service.serviceImage.validate(),
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ).cornerRadiusWithClipRRect(8),
        12.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(service.name.validate(), style: boldTextStyle()),
            4.height,
            Text(service.description.validate(), style: secondaryTextStyle()),
          ],
        ).expand(),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const _Card({required this.child, this.padding});

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
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
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

class _CodeItem extends StatelessWidget {
  final String title;
  final String actionText;
  final String? value;
  final VoidCallback onTap;

  const _CodeItem(
      {required this.title,
      required this.actionText,
      this.value,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichTextWidget(list: [
          TextSpan(text: title, style: boldTextStyle()),
          TextSpan(text: ' ', style: secondaryTextStyle()),
          TextSpan(text: locale.optional, style: secondaryTextStyle()),
        ]),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: Row(
            children: [
              Text(
                value ?? actionText,
                style: boldTextStyle(
                  decoration: TextDecoration.underline,
                  size: 14,
                ),
              ),
              4.width,
              Icon(
                value == null ? Icons.arrow_forward_ios : Icons.close,
                size: 12,
                color: primaryColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}
