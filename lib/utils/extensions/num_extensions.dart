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

  // Formats number with thousand grouping on integer part and configurable separators.
  String formatAmount({
    String thousandSeparator = ',',
    String decimalSeparator = '.',
    int decimal = 2,
  }) {
    final fixed = toStringAsFixed(decimal);
    final parts = fixed.split('.');
    String intPart = parts[0];
    String decPart = parts.length > 1 ? parts[1] : '';

    final rgx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    intPart = intPart.replaceAllMapped(rgx, (m) => '${m[1]}$thousandSeparator');

    if (decimal == 0) return intPart;
    return '$intPart$decimalSeparator$decPart';
  }

  String get formatPrice {
    // Default to US-style separators unless overridden elsewhere.
    const defaultThousand = ',';
    const defaultDecimal = '.';

    switch (appStore.currencyCode) {
      case 'VND':
        return '${formatAmount(thousandSeparator: defaultThousand, decimalSeparator: defaultDecimal, decimal: 0)}đ';
      default:
        final currencySymbol = appStore.currencySymbol;
        return '$currencySymbol${formatAmount(thousandSeparator: defaultThousand, decimalSeparator: defaultDecimal)}';
    }
  }
}
