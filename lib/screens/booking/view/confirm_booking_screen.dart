import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/common_app_dialog.dart';
import 'package:grow_tokyo_app/components/default_card.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/booking/booking_repository.dart';
import 'package:grow_tokyo_app/screens/booking/component/add_referral_code_modal.dart';
import 'package:grow_tokyo_app/screens/booking/component/service_item_component.dart';
import 'package:grow_tokyo_app/screens/coupon/model/coupon_list_response.dart';
import 'package:grow_tokyo_app/screens/coupon/view/add_coupon_screen.dart';
import 'package:grow_tokyo_app/screens/dashboard/view/dashboard_screen.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:grow_tokyo_app/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key, required this.isReschedule});

  final bool isReschedule;

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  Future<void> saveBookingAndPayment() async {
    try {
      appStore.setLoading(true);
      if (bookingRequestStore.bookingId == null) {
        await saveBooking();
      }

      if (mounted) {
        finish(context);
        finish(context);
      }
      showBookingCompleteDialog();
    } catch (e) {
      toast(e.toString());
    } finally {
      appStore.setLoading(false);
    }
  }

  Future<void> saveBooking() async {
    final tempDate = bookingRequestStore.date.validate();
    final tempTime = bookingRequestStore.time.validate();

    final dateString = "$tempDate $tempTime";
    final initialDateTime = DateTime.parse(dateString);

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
        element.previousTime =
            previousData.previousTime!.add(previousData.durationMin.minutes);
      }
    });

    final bookingJson = await saveBookingAPI(bookingRequestStore.toJson(
        dateTime: formatDate(initialDateTime.toString(),
            format: DateFormatConst.NEW_FORMAT),
        isRescheduleBooking: widget.isReschedule));
    bookingRequestStore.setBookingIdInRequest(bookingJson[CommonKey.bookingId]);
  }

  void showBookingCompleteDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) => CommonAppDialog(
        title: locale.bookingSuccessful,
        icon: ic_booking_success,
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
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: AppScaffold(
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
                  DefaultCard(
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
                  DefaultCard(
                    child: _RowData(
                      title: '${locale.date} & ${locale.time}',
                      value:
                          '${bookingRequestStore.date.validate()} at ${bookingRequestStore.time.validate()}',
                    ),
                  ),
                  16.height,
                  Text(locale.locationInformation, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: Column(
                      children: [
                        _RowData(
                          title: locale.branchName,
                          value: appStore.branchName.validate(),
                        ),
                        8.height,
                        _RowData(
                          title: locale.address,
                          value: appStore.branchAddress.validate(),
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  Text(locale.stylist, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: _RowData(
                      title: locale.stylist,
                      value: bookingRequestStore.employeeName.validate(),
                    ),
                  ),
                  16.height,
                  Text(locale.services, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: Column(
                      children: bookingRequestStore.selectedServiceList
                          .map(
                            (e) => ServiceItemComponent(
                                    key: ValueKey(e.id), service: e)
                                .paddingSymmetric(vertical: 4),
                          )
                          .toList(),
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
                    return DefaultCard(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: _CodeItem(
                        onTap: () => bookingRequestStore.couponCode != null
                            ? bookingRequestStore.removeCouponCodeInRequest()
                            : const AddCouponScreen()
                                .launch<CouponData>(context)
                                .then((val) {
                                if (val != null) {
                                  bookingRequestStore
                                      .setCouponCodeInRequest(val.code);
                                  bookingRequestStore
                                      .setCouponRewardPercentageInRequest(
                                          val.discountPercentage);
                                }
                              }),
                        title: locale.coupon,
                        actionText: locale.addCoupon,
                        value: bookingRequestStore.couponRewardPercentage,
                      ),
                    );
                  }),
                  16.height,
                  Observer(builder: (context) {
                    return DefaultCard(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: _CodeItem(
                        onTap: () => bookingRequestStore.referralCode != null
                            ? bookingRequestStore.removeReferralCodeInRequest()
                            : showModalBottomSheet<Map<String, dynamic>>(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) =>
                                    const AddReferralCodeModal(),
                              ).then((map) {
                                if (map == null) return;
                                bookingRequestStore.setReferralCodeInRequest(
                                    map['referralCode']);
                                bookingRequestStore
                                    .setReferralRewardPercentageInRequest(
                                        map['rewardPercentage']);
                              }),
                        title: locale.referralCode,
                        actionText: locale.addCode,
                        value: bookingRequestStore.referralRewardPercentage,
                      ),
                    );
                  }),
                  16.height,
                  DefaultCard(
                    child: Observer(builder: (context) {
                      return Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.usingXPoints(userStore.pointAmount),
                                style: boldTextStyle(),
                              ),
                              4.height,
                              Text(
                                locale.youWillSave$X(0), //TODO: Add amount;
                                style: secondaryTextStyle(),
                              ),
                            ],
                          ).expand(),
                          Switch.adaptive(
                            value: bookingRequestStore.useCredit,
                            onChanged:
                                bookingRequestStore.setUseCreditInRequest,
                          ),
                        ],
                      );
                    }),
                  ),
                  16.height,
                  Text(locale.paymentDetails, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: Column(
                      children: [
                        if (bookingRequestStore.referralCode != null) ...[
                          _RowData(
                            title: locale.referralDiscount,
                            value:
                                '-${bookingRequestStore.referralRewardPercentage}%',
                          ),
                          8.height,
                        ],
                        if (bookingRequestStore.couponCode != null) ...[
                          _RowData(
                            title: locale.couponDiscount,
                            value:
                                '-${bookingRequestStore.couponRewardPercentage}%',
                          ),
                          8.height,
                        ],
                        if (bookingRequestStore.useCredit) ...[
                          _RowData(
                            title: locale.points,
                            value: 'XXX',
                          ), //TODO: Add amount
                          8.height,
                        ],
                        _RowData(
                          title: locale.paymentMethod,
                          value: locale.payAtSalon,
                        ),
                      ],
                    ),
                  ),
                  120.height,
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
                  borderRadius: radiusOnly(
                      topLeft: defaultRadius, topRight: defaultRadius),
                ),
                child: AppButton(
                  text: locale.bookNow,
                  textStyle: boldTextStyle(color: primaryColor),
                  onTap: saveBookingAndPayment,
                ).paddingOnly(bottom: 20),
              ),
            ),
          ],
        ),
      ),
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
        16.width,
        Flexible(child: Marquee(child: Text(value, style: boldTextStyle()))),
      ],
    );
  }
}

class _CodeItem extends StatelessWidget {
  final String title;
  final String actionText;
  final double value;
  final VoidCallback onTap;

  const _CodeItem(
      {required this.title,
      required this.actionText,
      required this.value,
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
              value > 0
                  ? Text('-$value%', style: boldTextStyle(color: Colors.red))
                  : Text(
                      actionText,
                      style: boldTextStyle(
                        decoration: TextDecoration.underline,
                        size: 14,
                      ),
                    ),
              8.width,
              value == 0
                  ? const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: primaryColor,
                    )
                  : const CircleAvatar(
                      radius: 12,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.close,
                        size: 12,
                        color: white,
                      ),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
