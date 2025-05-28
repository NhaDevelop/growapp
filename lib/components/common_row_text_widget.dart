import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/common_base.dart';
import 'price_widget.dart';

class CommonRowTextWidget extends StatelessWidget {
  final String leadingText;
  final String trailingText;
  final Color? trailingTextColor;
  final int? trailingTxtSize;
  final int? leftWidgetFlex;
  final int? rightWidgetFlex;
  final bool isPrice;

  const CommonRowTextWidget({
    required this.leadingText,
    required this.trailingText,
    this.trailingTextColor,
    this.trailingTxtSize,
    this.leftWidgetFlex = 1,
    this.rightWidgetFlex = 2,
    this.isPrice = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Marquee(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: Text(leadingText, style: secondaryTextStyle(), textAlign: isRTL ? TextAlign.end : TextAlign.start),
        ).expand(flex: leftWidgetFlex),
        16.width,
        Align(
          alignment: Alignment.topRight,
          child: Marquee(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            child: isPrice
                ? PriceWidget(price: trailingText.toDouble(), color: appStore.isDarkMode ? Colors.white : Colors.black, size: 14)
                : Text(trailingText.validate(), style: boldTextStyle(size: trailingTxtSize.validate(value: 12), color: trailingTextColor)),
          ),
        ).expand(flex: rightWidgetFlex),
      ],
    );
  }
}
