import 'package:nb_utils/nb_utils.dart';

class PointTransactionsResponse {
  final List<PointTransactionData> transactions;

  PointTransactionsResponse({required this.transactions});

  factory PointTransactionsResponse.fromJson(Map<String, dynamic> json) {
    List<PointTransactionData> transactions = [];

    dynamic rawData = json['data'];
    if (rawData is Map && rawData.containsKey('data')) {
      rawData = rawData['data'];
    }

    if (rawData is List) {
      for (var transaction in rawData) {
        if (transaction is Map) {
          try {
            transactions.add(
              PointTransactionData.fromJson(
                Map<String, dynamic>.from(transaction),
              ),
            );
          } catch (e) {
            log('⚠️ Error parsing transaction item: $e');
          }
        }
      }
    }
    return PointTransactionsResponse(transactions: transactions);
  }
}

class PointTransactionData {
  final int? id;
  final double value;
  final double remainingValue;
  final String? description;
  final String? log;
  final String? createdAtStr;
  final String? expiresAtStr;
  final String? type;

  PointTransactionData({
    this.id,
    this.type = 'earned',
    this.value = 0.0,
    this.remainingValue = 0.0,
    this.description = '',
    this.log = '',
    this.createdAtStr,
    this.expiresAtStr,
  });

  String get displayTitle {
    if (description != null && description!.trim().isNotEmpty) {
      return description!.trim();
    }
    if (log != null && log!.trim().isNotEmpty) {
      return log!.trim();
    }
    final t = type?.toLowerCase() ?? '';
    if (t == 'earned' || t == 'booking_reward') {
      return 'Earned Points';
    }
    if (t == 'used' || t == 'deducted') {
      return 'Used Points';
    }
    return (type ?? 'Earned').capitalizeFirstLetter();
  }

  bool get isDeduction {
    final t = type?.toLowerCase() ?? '';
    return t == 'used' || t == 'deducted' || value < 0;
  }

  factory PointTransactionData.fromJson(Map<String, dynamic> json) {
    final valRaw = json['value'] ?? json['amount'] ?? json['points'] ?? 0;
    final valNum = valRaw is num
        ? valRaw.toDouble()
        : (double.tryParse(valRaw.toString()) ?? 0.0);

    final remRaw = json['remaining_value'] ?? json['remaining_points'] ?? 0;
    final remNum = remRaw is num
        ? remRaw.toDouble()
        : (double.tryParse(remRaw.toString()) ?? 0.0);

    return PointTransactionData(
      id: json['id'] is num
          ? (json['id'] as num).toInt()
          : int.tryParse(json['id']?.toString() ?? ''),
      type: json['type']?.toString() ??
          json['transaction_type']?.toString() ??
          'earned',
      value: valNum,
      remainingValue: remNum,
      description: json['description']?.toString() ?? '',
      log: json['log']?.toString() ?? json['title']?.toString() ?? '',
      createdAtStr: json['created_at']?.toString() ?? json['date']?.toString(),
      expiresAtStr: json['expires_at']?.toString(),
    );
  }
}
