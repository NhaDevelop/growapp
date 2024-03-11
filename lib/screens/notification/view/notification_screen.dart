import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.notifications,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: true,
      ),
      body: AnimatedListView(
        itemBuilder: (_, index) {
          return SettingItemWidget(
            title: 'Notification $index',
            subTitle: 'Notification $index Subtitle',
            leading: Image.asset('assets/app_logo.png', height: 48)
                .cornerRadiusWithClipRRect(context.width()),
            onTap: () => toast('Notification $index Clicked'),
          );
        },
      ),
    );
  }
}
