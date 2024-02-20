import 'package:flutter/material.dart';
import 'package:frezka/components/price_widget.dart';
import 'package:frezka/utils/colors.dart';
import 'package:frezka/utils/extensions/num_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class CommonBottomPriceWidget extends StatelessWidget {
  final String? title;
  final num? price;
  final String? buttonText;
  final Function? onTap;

  CommonBottomPriceWidget({this.title, this.price, this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: boxDecorationWithRoundedCorners(backgroundColor: secondaryColor, borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Marquee(child: Text(title.validate(), style: boldTextStyle(size: 14, color: Colors.white))),
              10.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PriceWidget(price: price.validate(), color: Colors.white),
                  8.width,
                  bookingRequestStore.totalTax != 0
                      ? Marquee(
                          child: Text(
                            '(${bookingRequestStore.totalTax.toPriceFormat()} ${locale.taxIncluded})',
                            style: primaryTextStyle(color: Colors.white70),
                          ),
                        ).expand()
                      : Offstage(),
                ],
              ),
            ],
          ).expand(),
          16.width,
          AppButton(
            color: Colors.white,
            child: Text(buttonText.validate(), style: boldTextStyle(color: Colors.black)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
