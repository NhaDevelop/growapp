import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/app_common.dart';
import '../utils/constants.dart';

class PriceWidget extends StatelessWidget {
  final num price;
  final String? priceText;
  final double? size;
  final Color? color;
  final Color? hourlyTextColor;
  final bool isBoldText;
  final bool isLineThroughEnabled;
  final bool isDiscountedPrice;
  final bool isHourlyService;
  final bool isFreeService;
  final int? decimalPoint;
  final String? seperator;

  const PriceWidget({super.key, 
    required this.price,
    this.size = 16.0,
    this.color,
    this.hourlyTextColor,
    this.isLineThroughEnabled = false,
    this.isBoldText = true,
    this.isDiscountedPrice = false,
    this.isHourlyService = false,
    this.isFreeService = false,
    this.decimalPoint,
    this.seperator,
    this.priceText,
  });

  @override
  Widget build(BuildContext context) {
    TextDecoration? textDecoration() => isLineThroughEnabled ? TextDecoration.lineThrough : null;

    TextStyle textStyle({int? aSize}) {
      return isBoldText
          ? boldTextStyle(
              size: aSize ?? size!.toInt(),
              color: color ?? context.primaryColor,
              decoration: textDecoration(),
            )
          : secondaryTextStyle(
              size: aSize ?? size!.toInt(),
              color: color ?? context.primaryColor,
              decoration: textDecoration(),
            );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          isDiscountedPrice ? ' -' : '',
          style: textStyle(),
        ),
        Text(
        priceText ?? "${leftCurrencyFormat()}${price.validate().toStringAsFixed(decimalPoint ?? getIntAsync(ConfigurationKeyConst.NO_OF_DECIMAL, defaultValue: DECIMAL_POINT)).formatNumberWithComma(seperator: getStringAsync(seperator ?? ConfigurationKeyConst.DECIMAL_SEPARATOR))}${rightCurrencyFormat()}",
          style: textStyle(),
        ),
      ],
    );
  }
}

String leftCurrencyFormat() {
  if (isCurrencyPositionLeft || isCurrencyPositionLeftWithSpace) {
    return isCurrencyPositionLeftWithSpace ? '${appStore.currencySymbol} ' : appStore.currencySymbol;
  }
  return '';
}

String rightCurrencyFormat() {
  if (isCurrencyPositionRight || isCurrencyPositionRightWithSpace) {
    return isCurrencyPositionRightWithSpace ? ' ${appStore.currencySymbol}' : appStore.currencySymbol;
  }
  return '';
}
