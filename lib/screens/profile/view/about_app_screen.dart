import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/profile/profile_repository.dart';
import 'package:grow_tokyo_app/screens/profile/shimmer/about_app_shimmer.dart';
import 'package:grow_tokyo_app/screens/profile/view/page_screen.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: locale.aboutApp),
      body: SnapHelperWidget(
        future: getPages(),
        initialData: pageListCached,
        loadingWidget: const AboutAppShimmer(),
        onSuccess: (pages) {
          return AnimatedListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: pages.length,
            itemBuilder: (_, index) {
              final page = pages[index];
              return SettingItemWidget(
                leading: ic_about.iconImage(size: 16),
                title: page.name,
                splashColor: Colors.transparent,
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: context.cardColor),
                onTap: () => PageScreen(data: page).launch(context),
              ).paddingOnly(top: 16);
            },
          );
        },
      ),
    );
  }
}
