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

  PointTransactionData({required this.value, required this.log});

  factory PointTransactionData.fromJson(Map<String, dynamic> json) {
    return PointTransactionData(
      value: json['value'],
      log: json['log'],
    );
  }
}
