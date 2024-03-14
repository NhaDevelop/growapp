class ReferralTransactionsResponse {
  final List<ReferralTransactionData> data;

  ReferralTransactionsResponse({required this.data});

  factory ReferralTransactionsResponse.fromJson(Map<String, dynamic> json) {
    List<ReferralTransactionData> referralTransactionData = [];
    if (json['data'] != null) {
      for (var v in (json['data'] as List)) {
        referralTransactionData.add(ReferralTransactionData.fromJson(v));
      }
    }
    return ReferralTransactionsResponse(
      data: referralTransactionData,
    );
  }
}

class ReferralTransactionData {
  final int value;
  final String log;
  final DateTime createdAt;

  ReferralTransactionData(
      {required this.value, required this.log, required this.createdAt});

  factory ReferralTransactionData.fromJson(Map<String, dynamic> json) {
    return ReferralTransactionData(
      value: json['value'],
      log: json['log'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
