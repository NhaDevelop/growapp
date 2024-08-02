class ReferralTransactionsResponse {
  final List<ReferralTransactionData> data;

  ReferralTransactionsResponse({required this.data});

  factory ReferralTransactionsResponse.fromJson(Map<String, dynamic> json) {
    List<ReferralTransactionData> referralTransactionData = [];
    for (var v in (json['data'])) {
      referralTransactionData.add(ReferralTransactionData.fromJson(v));
    }
    return ReferralTransactionsResponse(
      data: referralTransactionData,
    );
  }
}

class ReferralTransactionData {
  final double value;
  final String log;
  final DateTime createdAt;

  ReferralTransactionData(
      {required this.value, required this.log, required this.createdAt});

  factory ReferralTransactionData.fromJson(Map<String, dynamic> json) {
    return ReferralTransactionData(
      value: (json['value'] as num).toDouble(),
      log: json['log'],
      createdAt: DateTime.parse(json['created_at']).toLocal().toLocal(),
    );
  }
}
