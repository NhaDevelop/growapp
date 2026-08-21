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

  String get shortMonth {
    final parts = month.trim().split(' ');
    return parts.isNotEmpty ? parts[0] : month;
  }

  factory MonthlyPointHistory.fromJson(Map<String, dynamic> json) {
    final earnedRaw = json['earned'] ?? json['points'] ?? json['value'] ?? json['amount'] ?? 0;
    final usedRaw = json['used'] ?? 0;

    return MonthlyPointHistory(
      month: json['month']?.toString() ??
          json['name']?.toString() ??
          json['label']?.toString() ??
          '',
      earned: earnedRaw is num
          ? earnedRaw.toDouble()
          : (double.tryParse(earnedRaw.toString()) ?? 0.0),
      used: usedRaw is num
          ? usedRaw.toDouble()
          : (double.tryParse(usedRaw.toString()) ?? 0.0),
    );
  }
}

class PointData {
  final double amount;
  final double equivalentAmount;
  final Map<String, double> conversionRates;
  final double expiringEndMonth;
  final double expiringNextMonth;
  final List<MonthlyPointHistory> earnedPointsHistory;

  PointData({
    required this.amount,
    required this.equivalentAmount,
    required this.conversionRates,
    required this.expiringEndMonth,
    required this.expiringNextMonth,
    required this.earnedPointsHistory,
  });

  factory PointData.fromJson(Map<String, dynamic> json,
      {List<PointTransactionData>? transactions}) {
    final dataMap = json['data'] is Map ? json['data'] as Map : json;
    final data = Map<String, dynamic>.from(dataMap);

    final countries = countryList();
    final conversionRates = <String, double>{};
    for (final country in countries) {
      final rate = data[country.currencyCode.toLowerCase()] as num?;
      conversionRates[country.currencyCode] = rate?.toDouble() ?? 0;
    }

    final activeBalRaw = data['active_balance'] ??
        data['total_points'] ??
        data['amount'] ??
        data['credit'] ??
        data['points'];

    final totalAmount = activeBalRaw is num
        ? activeBalRaw.toDouble()
        : (double.tryParse(activeBalRaw?.toString() ?? '0') ?? 0.0);

    final equivRaw =
        data['equivalent_amount'] ?? data['equivalent'] ?? totalAmount;
    final equivAmount = equivRaw is num
        ? equivRaw.toDouble()
        : (double.tryParse(equivRaw?.toString() ?? '0') ?? totalAmount);

    final alertsMap = data['alerts'] is Map ? data['alerts'] as Map : data;
    final alerts = Map<String, dynamic>.from(alertsMap);

    final endMonthRaw = alerts['expiring_this_month'] ??
        alerts['expiring_end_of_month'] ??
        alerts['expiring_end_month'] ??
        0;
    double endMonth = endMonthRaw is num
        ? endMonthRaw.toDouble()
        : (double.tryParse(endMonthRaw?.toString() ?? '0') ?? 0.0);

    final nextMonthRaw = alerts['expiring_next_month'] ?? 0;
    double nextMonth = nextMonthRaw is num
        ? nextMonthRaw.toDouble()
        : (double.tryParse(nextMonthRaw?.toString() ?? '0') ?? 0.0);

    // Dynamic fallback calculation for expiring alerts if missing or 0 in API
    if (endMonth == 0 &&
        nextMonth == 0 &&
        transactions != null &&
        transactions.isNotEmpty) {
      final now = DateTime.now();
      final currentMonthStart = DateTime(now.year, now.month, 1);
      final nextMonthStart = DateTime(now.year, now.month + 1, 1);
      final monthAfterNextStart = DateTime(now.year, now.month + 2, 1);

      for (var tx in transactions) {
        if (!tx.isDeduction &&
            tx.expiresAtStr != null &&
            tx.expiresAtStr!.isNotEmpty) {
          try {
            final expireDate = DateTime.parse(tx.expiresAtStr!);
            final val = tx.remainingValue > 0 ? tx.remainingValue : tx.value;

            if (!expireDate.isBefore(currentMonthStart) &&
                expireDate.isBefore(nextMonthStart)) {
              endMonth += val;
            } else if (!expireDate.isBefore(nextMonthStart) &&
                expireDate.isBefore(monthAfterNextStart)) {
              nextMonth += val;
            }
          } catch (_) {}
        }
      }
    }

    List<MonthlyPointHistory> historyList = [];
    final rawChart = data['chart'] ??
        data['earned_points_history'] ??
        data['monthly_history'] ??
        data['earned_history'];

    if (rawChart is List) {
      for (var item in rawChart) {
        if (item is Map) {
          historyList.add(
              MonthlyPointHistory.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    } else if (rawChart is Map) {
      rawChart.forEach((key, value) {
        if (value is Map) {
          historyList.add(MonthlyPointHistory.fromJson(
              {'month': key.toString(), ...Map<String, dynamic>.from(value)}));
        } else {
          historyList.add(MonthlyPointHistory(
            month: key.toString(),
            earned: value is num
                ? value.toDouble()
                : (double.tryParse(value.toString()) ?? 0.0),
            used: 0.0,
          ));
        }
      });
    }

    // Default or aggregate 6 months if history is empty or all zero
    bool isAllZero = historyList.isEmpty ||
        historyList.every((e) => e.earned == 0 && e.used == 0);

    if (isAllZero) {
      final now = DateTime.now();
      final monthNames = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];

      Map<String, MonthlyPointHistory> monthMap = {};
      List<MonthlyPointHistory> generatedList = [];

      for (int i = 5; i >= 0; i--) {
        final date = DateTime(now.year, now.month - i, 1);
        final monthKey =
            '${date.year}-${date.month.toString().padLeft(2, '0')}';
        final monthName = '${monthNames[date.month - 1]} ${date.year}';
        final item =
            MonthlyPointHistory(month: monthName, earned: 0.0, used: 0.0);
        monthMap[monthKey] = item;
        generatedList.add(item);
      }

      if (transactions != null && transactions.isNotEmpty) {
        for (var tx in transactions) {
          if (tx.createdAtStr != null && tx.createdAtStr!.isNotEmpty) {
            try {
              final parsedDate = DateTime.parse(tx.createdAtStr!);
              final key =
                  '${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}';
              if (monthMap.containsKey(key)) {
                final existing = monthMap[key]!;
                final newEarned = tx.isDeduction
                    ? existing.earned
                    : (existing.earned + tx.value.abs());
                final newUsed = tx.isDeduction
                    ? (existing.used + tx.value.abs())
                    : existing.used;
                monthMap[key] = MonthlyPointHistory(
                  month: existing.month,
                  earned: newEarned,
                  used: newUsed,
                );
              }
            } catch (_) {}
          }
        }
        historyList = generatedList.map((e) {
          final matchingKey = monthMap.keys.firstWhere(
            (k) => monthMap[k]?.month == e.month,
            orElse: () => '',
          );
          return matchingKey.isNotEmpty ? monthMap[matchingKey]! : e;
        }).toList();
      } else if (historyList.isEmpty) {
        historyList = generatedList;
      }
    }

    return PointData(
      amount: totalAmount,
      equivalentAmount: equivAmount,
      conversionRates: conversionRates,
      expiringEndMonth: endMonth,
      expiringNextMonth: nextMonth,
      earnedPointsHistory: historyList,
    );
  }
}
