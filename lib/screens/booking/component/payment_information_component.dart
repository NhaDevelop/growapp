import 'package:flutter/material.dart';
import 'package:frezka/components/price_widget.dart';
import 'package:frezka/utils/colors.dart';
import 'package:frezka/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_row_text_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../cart/model/cart_list_response.dart';
import '../../dashboard/component/booking_list_component.dart';
import '../model/booking_list_response.dart';
import '../view/booking_detail_screen.dart';
import '../view/complete_payment_screen.dart';

class PaymentInformationComponent extends StatelessWidget {
  final BookingListData booking;

  PaymentInformationComponent({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAllLabel(
          label: locale.priceDetails,
          trailingTextColor: Colors.red,
          isShowAll: false,
          onTap: () {
            //
          },
        ),
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              /// Subtotal
              SettingItemWidget(
                title: locale.subtotal,
                titleTextStyle: secondaryTextStyle(),
                padding: EdgeInsets.zero,
                trailing: Marquee(
                  child: PriceWidget(price: booking.sumOfServicePrices.validate(), color: textPrimaryColorGlobal, size: 14),
                ),
              ),
              10.height,

              /// Product Amount
              if (booking.sumOfProductPrices != 0)
                SettingItemWidget(
                  title: locale.productAmount,
                  titleTextStyle: secondaryTextStyle(),
                  padding: EdgeInsets.zero,
                  trailing: Marquee(
                    child: PriceWidget(price: booking.sumOfProductPrices.validate(), color: textPrimaryColorGlobal, size: 14),
                  ),
                ).paddingBottom(10),

              /// Tax
              if (booking.taxDetails != null)
                Column(
                  children: List.generate(
                    booking.taxDetails.validate().length,
                    (index) {
                      TaxDetail tax = booking.taxDetails.validate()[index];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${tax.taxName.validate()}: ${tax.taxType == TaxType.FIXED ? appStore.currencySymbol : ''}${tax.taxType == TaxType.FIXED ? tax.taxAmount.validate() : tax.taxValue.validate()}${tax.taxType == TaxType.PERCENT ? '%' : ''}',
                            style: secondaryTextStyle(),
                          ),
                          16.width,
                          if (tax.taxType == TaxType.PERCENT) PriceWidget(price: tax.taxAmount.validate(), color: textPrimaryColorGlobal, size: 14),
                          if (tax.taxType == TaxType.FIXED) PriceWidget(price: tax.taxAmount.validate(), color: textPrimaryColorGlobal, size: 14),
                        ],
                      ).paddingBottom(10);
                    },
                  ),
                ),

              /// TIP
              if (booking.tip != 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(locale.tip, style: secondaryTextStyle()),
                    16.width,
                    PriceWidget(price: booking.tip.validate(), color: textPrimaryColorGlobal, size: 14),
                  ],
                ).paddingBottom(10),

              /// Total Amount
              SettingItemWidget(
                title: locale.total,
                titleTextStyle: secondaryTextStyle(),
                padding: EdgeInsets.zero,
                paddingBeforeTrailing: 16,
                trailing: Marquee(child: PriceWidget(price: booking.totalAmount.validate(), color: context.primaryColor, size: 16)),
              ),
            ],
          ),
        ),
        if (booking.payment != null)
          Column(
            children: [
              ViewAllLabel(
                label: locale.paymentDetails,
                trailingTextColor: Colors.red,
                isShowAll: false,
                onTap: () {
                  //
                },
              ),
              Container(
                decoration: boxDecorationDefault(color: context.cardColor),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (booking.payment!.externalTransactionId.validate().isNotEmpty)
                      Column(
                        children: [
                          CommonRowTextWidget(
                            leadingText: locale.transactionId,
                            trailingText: booking.payment!.externalTransactionId.validate(),
                            leftWidgetFlex: 3,
                            rightWidgetFlex: 7,
                          ),
                          10.height,
                        ],
                      ),
                    if (booking.payment!.transactionType != null)
                      SettingItemWidget(
                        title: locale.paymentMethod,
                        titleTextStyle: secondaryTextStyle(),
                        padding: EdgeInsets.zero,
                        trailing: Marquee(
                          child: Text(booking.payment!.transactionType.validate(), style: boldTextStyle(size: 14)),
                        ),
                      ).paddingBottom(10),
                    SettingItemWidget(
                      title: locale.paymentStatus,
                      titleTextStyle: secondaryTextStyle(),
                      padding: EdgeInsets.zero,
                      trailing: Marquee(
                        child: Text(booking.payment!.paymentStatus == 1 ? locale.paid : locale.pending, style: boldTextStyle(size: 14)),
                      ),
                    ),
                    10.height,
                  ],
                ),
              ),
            ],
          )
        else if (booking.status == BookingStatusConst.COMPLETED &&
            (booking.payment == null || (booking.payment != null && booking.payment!.paymentStatus == 0)))
          Column(
            children: [
              16.height,
              AppButton(
                text: locale.payNow,
                textColor: white,
                color: secondaryColor,
                width: context.width(),
                onTap: () async {
                  bool? res = await CompletePaymentScreen(booking).launch(context);

                  if (res ?? false) {
                    onBookingDetailUpdate.call();
                    onBookingListUpdate.call('');
                  }
                },
              ),
            ],
          ),
      ],
    );
  }
}
