class PointTransactionsResponse {
  final List<PointTransactionData> transactions;

  PointTransactionsResponse({required this.transactions});

  factory PointTransactionsResponse.fromJson(Map<String, dynamic> json) {
    List<PointTransactionData> transactions = [];
    for (var transaction in json['data']) {
      transactions.add(PointTransactionData.fromJson(transaction));
    }
    return PointTransactionsResponse(transactions: transactions);
  }
}

class PointTransactionData {
  final double value;
  final String log;
  final String? createdAtStr;
  final String type;

  PointTransactionData(
      {required this.type,
      required this.value,
      required this.log,
      required this.createdAtStr});

  factory PointTransactionData.fromJson(Map<String, dynamic> json) {
    return PointTransactionData(
      type: json['type'],
      value: (json['value'] as num).toDouble(),
      log: json['log'],
      createdAtStr: json['created_at'],
    );
  }
}
