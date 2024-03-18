import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class AppLanguageScreen extends StatefulWidget {
  const AppLanguageScreen({super.key});

  @override
  State<AppLanguageScreen> createState() => _AppLanguageScreenState();
}

class _AppLanguageScreenState extends State<AppLanguageScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context, title: locale.appLanguage),
      body: AnimatedListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: languageList().length,
        itemBuilder: (_, index) {
          final language = languageList()[index];
          return SettingItemWidget(
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            title: language.name.validate(),
            leading: Image.asset(
              language.flag.validate(),
              height: 20,
              width: 20,
            ),
            trailing: Observer(builder: (context) {
              return appStore.selectedLanguageCode == language.languageCode
                  ? Icon(Icons.check, color: context.iconColor)
                  : const SizedBox();
            }),
            onTap: () {
              appStore.setLanguage(language.languageCode!);
              setState(() {});
              finish(context, true);
            },
          ).paddingTop(16);
        },
      ),
    );
  }
}
