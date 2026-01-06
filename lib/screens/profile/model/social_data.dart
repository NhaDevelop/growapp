class SocialData {
  final String facebookLink;
  final String instagramLink;
  final String telegramChannel;
  final String messengerChannel;
  final String facebookVnLink;
  final String instagramVnLink;
  final String zaloLink;
  SocialData(
      {this.facebookLink = '#',
      this.instagramLink =
          'https://www.instagram.com/bkk_growtokyo?igsh=YnF3ODBwcWEwZ3Q3',
      this.telegramChannel = '#',
      this.messengerChannel = '#',
      this.zaloLink = 'https://zalo.me/0931542264',
      this.facebookVnLink = 'https://m.facebook.com/growHCMC/',
      this.instagramVnLink =
          'https://www.instagram.com/growtokyo.hcmc?igsh=MW9xNXRqZWxjd3ducA=='});

  factory SocialData.fromJson(Map<String, dynamic> json) {
    // Fix invalid Instagram link from backend
    String? instagramFromApi = json['instagram_link'];
    String instagramLink =
        'https://www.instagram.com/bkk_growtokyo?igsh=YnF3ODBwcWEwZ3Q3';

    // Only use backend link if it's valid and not the old 'growtokyo' account
    if (instagramFromApi != null &&
        instagramFromApi.isNotEmpty &&
        !instagramFromApi.contains('/growtokyo/') &&
        instagramFromApi != '#') {
      instagramLink = instagramFromApi;
    }

    return SocialData(
        facebookLink: json['facebook_link'] ??
            'https://www.facebook.com/share/16F7KGU3yZ/',
        instagramLink: instagramLink,
        telegramChannel: json['telegram_chanel'],
        messengerChannel: json['messenger_chanel'],
        zaloLink: json['zalo_link'] ?? 'https://zalo.me/0931542264',
        facebookVnLink:
            json['facebook_vn_link'] ?? 'https://m.facebook.com/growHCMC/',
        instagramVnLink: json['instagram_vn_link'] ??
            'https://www.instagram.com/growtokyo.hcmc?igsh=MW9xNXRqZWxjd3ducA==');
  }

  @override
  String toString() => zaloLink;
}
