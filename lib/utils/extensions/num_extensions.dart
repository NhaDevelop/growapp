import 'package:grow_tokyo_app/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/price_widget.dart';
import '../constants.dart';

extension numExt on num {
  String toPriceFormat() {
    return '${leftCurrencyFormat()}${toStringAsFixed(getIntAsync(ConfigurationKeyConst.NO_OF_DECIMAL, defaultValue: DECIMAL_POINT)).formatNumberWithComma(seperator: getStringAsync(ConfigurationKeyConst.DECIMAL_SEPARATOR))}${rightCurrencyFormat()}';
  }

  String get formatDoubleDigit {
    return this < 10 ? '0$this' : '$this';
  }

  String formatNumberWithComma({String seperator = ',', int decimal = 2}) {
    return toStringAsFixed(decimal).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}$seperator');
  }

  String get formatPrice {
    switch (appStore.currencyCode) {
      case 'VND':
        return '${formatNumberWithComma(decimal: 0)}đ';
      default:
        final currencySymbol = appStore.currencySymbol;
        return '$currencySymbol${formatNumberWithComma()}';
    }
  }
}
