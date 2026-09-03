import 'package:grow_tokyo_app/screens/points/model/point_transactions_response.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';

class MonthlyPointHistory {
  final String month;
  final double earned;
  final double used;

  MonthlyPointHistory({
    required this.month,
    required this.earned,
    required this.used,
  });

  factory MonthlyPointHistory.fromJson(Map<String, dynamic> json) {
    final eRaw = json['earned'] ?? json['earned_points'] ?? 0;
    final uRaw = json['used'] ?? json['used_points'] ?? 0;
    return MonthlyPointHistory(
      month: json['month']?.toString() ?? '',
      earned: eRaw is num
          ? eRaw.toDouble()
          : (double.tryParse(eRaw.toString()) ?? 0.0),
      used: uRaw is num
          ? uRaw.toDouble()
          : (double.tryParse(uRaw.toString()) ?? 0.0),
    );
  }
}

class PointData {
  final double amount;
  final double expiringThisMonth;
  final double expiringNextMonth;
  final List<MonthlyPointHistory> monthlyHistory;
  final Map<String, double> conversionRates;

  PointData({
    required this.amount,
    this.expiringThisMonth = 0.0,
    this.expiringNextMonth = 0.0,
    this.monthlyHistory = const [],
    this.conversionRates = const {},
  });

  double get equivalentAmount => amount;

  factory PointData.fromJson(
    Map<String, dynamic> json, {
    List<PointTransactionData> historyList = const [],
  }) {
    Map<String, dynamic> dataMap = json;
    if (json.containsKey('data') && json['data'] is Map) {
      dataMap = Map<String, dynamic>.from(json['data']);
    }

    final amtRaw = dataMap['active_balance'] ??
        dataMap['balance'] ??
        dataMap['credit'] ??
        json['credit'] ??
        0;

    final amount = amtRaw is num
        ? amtRaw.toDouble()
        : (double.tryParse(amtRaw.toString()) ?? 0.0);

    double expThis = 0.0;
    double expNext = 0.0;

    if (dataMap.containsKey('alerts') && dataMap['alerts'] is Map) {
      final alerts = Map<String, dynamic>.from(dataMap['alerts']);
      final rawThis = alerts['expiring_this_month'] ?? 0;
      final rawNext = alerts['expiring_next_month'] ?? 0;

      expThis = rawThis is num
          ? rawThis.toDouble()
          : (double.tryParse(rawThis.toString()) ?? 0.0);

      expNext = rawNext is num
          ? rawNext.toDouble()
          : (double.tryParse(rawNext.toString()) ?? 0.0);
    }

    List<MonthlyPointHistory> history = [];

    if (dataMap.containsKey('chart') && dataMap['chart'] is List) {
      for (var item in dataMap['chart']) {
        if (item is Map) {
          history.add(
            MonthlyPointHistory.fromJson(
              Map<String, dynamic>.from(item),
            ),
          );
        }
      }
    }

    final countries = countryList();
    final conversionRates = <String, double>{};
    for (final country in countries) {
      final rateRaw = json[country.currencyCode.toLowerCase()] ??
          dataMap[country.currencyCode.toLowerCase()];
      final rate = rateRaw is num
          ? rateRaw.toDouble()
          : (double.tryParse(rateRaw?.toString() ?? '') ?? 0.0);
      conversionRates[country.currencyCode] = rate;
    }

    return PointData(
      amount: amount,
      expiringThisMonth: expThis,
      expiringNextMonth: expNext,
      monthlyHistory: history,
      conversionRates: conversionRates,
    );
  }
}
