import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: locale.socialMedia),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SettingItemWidget(
            leading: Image.asset(ic_facebook_colored, height: 16, width: 16),
            title: locale.facebook,
            splashColor: Colors.transparent,
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            onTap: () {},
          ),
          16.height,
          SettingItemWidget(
            leading: Image.asset(ic_instagram_colored, height: 16, width: 16),
            title: locale.instagram,
            splashColor: Colors.transparent,
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
