import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/screens/app_country_screen.dart';
import 'package:grow_tokyo_app/screens/auth/view/change_password_screen.dart';
import 'package:grow_tokyo_app/screens/profile/components/deletion_confirm_dialog.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../main.dart';
import '../../../network/rest_apis.dart';
import '../../../utils/app_common.dart';
import '../../app_language_screen.dart';
import '../../auth/auth_repository.dart';
import '../../dashboard/view/dashboard_screen.dart';
// import '../components/theme_selection_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.setting,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: AnimatedScrollView(
        padding: const EdgeInsets.all(16),
        listAnimationType: ListAnimationType.None,
        children: [
          SettingItemWidget(
            leading: ic_app_language.iconImage(size: 16),
            title: locale.language,
            splashColor: Colors.transparent,
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            onTap: () {
              const AppLanguageScreen().launch(context).then((value) {
                setState(() {});
              });
            },
          ),
          16.height,
          SettingItemWidget(
            leading: ic_app_language.iconImage(size: 16),
            title: locale.country,
            splashColor: Colors.transparent,
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            onTap: () {
              const AppCountryScreen().launch(context).then((value) {
                setState(() {});
              });
            },
          ),
          // SettingItemWidget(
          //   leading: ic_dark_mode.iconImage(size: 16),
          //   title: locale.appTheme,
          //   onTap: () async {
          //     await showInDialog(
          //       context,
          //       builder: (context) => const ThemeSelectionDaiLog(),
          //       contentPadding: EdgeInsets.zero,
          //     );
          //   },
          // ),
          if (!isSocialLoginType) ...[
            16.height,
            SettingItemWidget(
              leading: ic_lock.iconImage(size: 16),
              title: locale.changePassword,
              splashColor: Colors.transparent,
              decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: context.cardColor),
              onTap: () {
                doIfLoggedIn(context, () {
                  setState(() {});
                  const ChangePasswordScreen().launch(context);
                });
              },
            ),
          ],
          if (appStore.isLoggedIn) ...[
            16.height,
            SettingItemWidget(
              leading: ic_delete_account.iconImage(size: 16),
              paddingBeforeTrailing: 4,
              title: locale.deleteAccount,
              decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: context.cardColor),
              onTap: () async {
                final isConfirm = await showDialog(
                      context: context,
                      builder: (context) => const DeletionConfirmDialog(),
                    ) ??
                    false;

                if (!isConfirm) return;

                appStore.setLoading(true);

                deleteAccountCompletely().then((value) async {
                  await clearPreferences();
                  appStore.setLoading(false);

                  toast(value.message);

                  push(const DashboardScreen(),
                      isNewTask: true,
                      pageRouteAnimation: PageRouteAnimation.Fade);
                }).catchError((e) {
                  appStore.setLoading(false);
                  toast(e.toString());
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}
