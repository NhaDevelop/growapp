class SocialData {
  final String facebookLink;
  final String instagramLink;
  final String telegramChannel;
  final String messengerChannel;

  SocialData({
    this.facebookLink = '#',
    this.instagramLink = '#',
    this.telegramChannel = '#',
    this.messengerChannel = '#',
  });

  factory SocialData.fromJson(Map<String, dynamic> json) {
    return SocialData(
      facebookLink: json['facebook_link'],
      instagramLink: json['instagram_link'],
      telegramChannel: json['telegram_chanel'],
      messengerChannel: json['messenger_chanel'],
    );
  }
}
