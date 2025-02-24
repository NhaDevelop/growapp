class SocialData {
  final String facebookLink;
  final String instagramLink;
  final String telegramChannel;
  final String messengerChannel;
  final String facebookVnLink;
  final String zaloLink;
  SocialData(
      {this.facebookLink = '#',
      this.instagramLink = '#',
      this.telegramChannel = '#',
      this.messengerChannel = '#',
      this.zaloLink = 'https://zalo.me/0931542264',
      this.facebookVnLink = 'https://www.facebook.com/share/1LpmhFpgKa/'});

  factory SocialData.fromJson(Map<String, dynamic> json) {
    return SocialData(
        facebookLink:
            json['facebook_link'] ?? 'https://www.facebook.com/share/16F7KGU3yZ/',
        instagramLink: json['instagram_link'],
        telegramChannel: json['telegram_chanel'],
        messengerChannel: json['messenger_chanel'],
        zaloLink: json['zalo_link'] ?? 'https://zalo.me/0931542264',
        facebookVnLink: json['facebook_vn_link'] ??
            'https://www.facebook.com/share/1LpmhFpgKa/');
  }

  @override
  String toString() => zaloLink;
}
