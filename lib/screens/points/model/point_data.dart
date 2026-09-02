import 'package:grow_tokyo_app/utils/common_base.dart';

class PointData {
  final double amount;
  final Map<String, double> conversionRates;

  PointData({required this.amount, required this.conversionRates});

  factory PointData.fromJson(Map<String, dynamic> json) {
    final countries = countryList();
    final conversionRates = <String, double>{};
    for (final country in countries) {
      final rate = json[country.currencyCode.toLowerCase()] as num?;
      conversionRates[country.currencyCode] = rate?.toDouble() ?? 0;
    }

    return PointData(
      amount: (json['credit'] as num).toDouble(),
      conversionRates: conversionRates,
    );
  }
}
