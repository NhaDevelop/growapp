import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/price_widget.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/extensions/num_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class CommonBottomPriceWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final num? price;
  final String? buttonText;
  final Function? onTap;

  const CommonBottomPriceWidget(
      {super.key,
      this.title,
      this.subtitle,
      this.price,
      this.buttonText,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: boxDecorationWithRoundedCorners(
            backgroundColor: secondaryColor,
            borderRadius:
                radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Marquee(
                  child: Text(
                    title.validate(),
                    style: boldTextStyle(size: 14, color: Colors.white),
                  ),
                ),
                if (subtitle != null) ...[
                  10.height,
                  Marquee(
                    child: Text(
                      subtitle.validate(),
                      style: secondaryTextStyle(color: Colors.white70),
                    ),
                  ),
                ],
                if (price.validate() != 0) ...[
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
                          : const Offstage(),
                    ],
                  ),
                ],
              ],
            ).expand(),
            16.width,
            AppButton(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              onTap: onTap,
              child: Text(buttonText.validate(),
                  style: boldTextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
