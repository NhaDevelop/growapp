class ReferralData {
  final String code;
  final double rewardPercentage;

  ReferralData({required this.code, required this.rewardPercentage});

  factory ReferralData.fromJson(Map<String, dynamic> json) {
    return ReferralData(
      code: json['referral_code'],
      rewardPercentage:
          (json['referral_reward_percent'] as num? ?? 0).toDouble(),
    );
  }
}
