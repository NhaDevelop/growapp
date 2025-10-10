class NotificationUserResponse {
  int? id;
  String? name;
  double? points;
  String? fcmToken;

  NotificationUserResponse({
    this.id,
    this.name,
    this.points,
    this.fcmToken,
  });

  factory NotificationUserResponse.fromJson(Map<String, dynamic> json) {
    return NotificationUserResponse(
      id: json['id'],
      name: json['name'],
      points: (json['points'] as num?)?.toDouble(),
      fcmToken: json['fcm_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (points != null) data['points'] = points;
    if (fcmToken != null) data['fcm_token'] = fcmToken;
    return data;
  }
}