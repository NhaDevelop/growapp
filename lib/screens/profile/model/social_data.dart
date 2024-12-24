class SocialData {
  final String facebookLink;
  final String instagramLink;
  final String telegramChannel;
  final String messengerChannel;
  final String zaloLink;
  SocialData(
      {this.facebookLink = '#',
      this.instagramLink = '#',
      this.telegramChannel = '#',
      this.messengerChannel = '#',
      this.zaloLink = 'https://zalo.me/0931542264'});

  factory SocialData.fromJson(Map<String, dynamic> json) {
    return SocialData(
        facebookLink: json['facebook_link'],
        instagramLink: json['instagram_link'],
        telegramChannel: json['telegram_chanel'],
        messengerChannel: json['messenger_chanel'],
        zaloLink: 'https://zalo.me/0931542264');
  }

  @override
  String toString() => zaloLink;
}
