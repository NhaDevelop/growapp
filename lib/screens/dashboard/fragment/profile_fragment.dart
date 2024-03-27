import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/loader_widget.dart';
import 'package:grow_tokyo_app/components/logout_confirmation_dialog.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/auth/auth_repository.dart';
import 'package:grow_tokyo_app/screens/dashboard/view/dashboard_screen.dart';
import 'package:grow_tokyo_app/screens/profile/view/about_app_screen.dart';
import 'package:grow_tokyo_app/screens/profile/view/setting_screen.dart';
import 'package:grow_tokyo_app/screens/profile/view/social_media_screen.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/default_user_image_placeholder.dart';
import '../../../utils/images.dart';
import '../../auth/view/edit_profile_screen.dart';
// import '../../cart/view/select_address_screen.dart';
// import '../../order/view/order_list_screen.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedScrollView(
            children: [
              Container(
                width: context.width(),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20),
                  backgroundColor: context.primaryColor,
                ),
                child: Column(
                  children: [
                    Text(
                      locale.profile,
                      style:
                          boldTextStyle(color: white, size: APPBAR_TEXT_SIZE),
                      textAlign: TextAlign.center,
                    ).paddingTop(50),
                    24.height,
                    appStore.isLoggedIn
                        ? Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      width: 100,
                                      height: 100,
                                      decoration:
                                          boxDecorationWithRoundedCorners(
                                        boxShape: BoxShape.circle,
                                        border:
                                            Border.all(color: white, width: 1),
                                      ),
                                      child: Observer(builder: (context) {
                                        return CachedImageWidget(
                                          url: userStore.userProfileImage
                                              .validate(),
                                          height: 120,
                                          fit: BoxFit.cover,
                                          width: 120,
                                          radius: 150,
                                          child:
                                              const DefaultUserImagePlaceholder(),
                                        );
                                      }),
                                    ),
                                    Positioned(
                                      bottom: 12,
                                      right: -8,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(6),
                                        decoration: boxDecorationDefault(
                                          shape: BoxShape.circle,
                                          color: white,
                                          border: Border.all(
                                            color: context.primaryColor,
                                          ),
                                        ),
                                        child: Icon(Icons.edit,
                                            color: context.primaryColor,
                                            size: 18),
                                      ).onTap(
                                        () {
                                          const EditProfileScreen().launch(
                                              context,
                                              pageRouteAnimation:
                                                  PageRouteAnimation.Fade);
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              24.height,
                              Observer(builder: (context) {
                                return Text(
                                  userStore.userFullName.validate(),
                                  style: boldTextStyle(size: 18, color: white),
                                ).center();
                              }),
                              4.height,
                              Observer(builder: (context) {
                                return Text(
                                  userStore.userEmail.validate(),
                                  style: secondaryTextStyle(
                                      color: const Color(0xFFBDBDBD)),
                                ).center();
                              }),
                              24.height
                            ],
                          )
                        : const SizedBox(height: 25),
                  ],
                ),
              ),
              Column(
                children: [
                  // SettingItemWidget(
                  //   title: locale.orders,
                  //   titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                  //   subTitle: locale.seeYourOrders,
                  //   leading: ic_order.iconImage(fit: BoxFit.cover, size: 16),
                  //   decoration: boxDecorationWithRoundedCorners(
                  //       backgroundColor: context.cardColor),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16, vertical: 12),
                  //   onTap: () {
                  //     const OrderListScreen().launch(context,
                  //         pageRouteAnimation: PageRouteAnimation.Fade);
                  //   },
                  //   hoverColor: Colors.transparent,
                  //   highlightColor: Colors.transparent,
                  //   splashColor: Colors.transparent,
                  // ).visible(appStore.isLoggedIn),
                  // if (appStore.isLoggedIn) 16.height,
                  // SettingItemWidget(
                  //   title: locale.myAddresses,
                  //   titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                  //   subTitle: locale.manageYourAddresses,
                  //   leading:
                  //       ic_location.iconImage(fit: BoxFit.cover, size: 16),
                  //   decoration: boxDecorationWithRoundedCorners(
                  //       backgroundColor: context.cardColor),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16, vertical: 12),
                  //   onTap: () {
                  //     const SelectAddressScreen(isFromProfile: true).launch(
                  //         context,
                  //         pageRouteAnimation: PageRouteAnimation.Fade);
                  //   },
                  //   hoverColor: Colors.transparent,
                  //   highlightColor: Colors.transparent,
                  //   splashColor: Colors.transparent,
                  // ).visible(appStore.isLoggedIn),
                  // if (appStore.isLoggedIn) 16.height,
                  SettingItemWidget(
                    title: locale.setting,
                    titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                    subTitle: !isSocialLoginType
                        ? '${locale.changePassword}, ${locale.language}, ${locale.country}, ${locale.deleteAccount}'
                        : '${locale.appLanguage}, ${locale.country}, ${locale.deleteAccount}',
                    leading: ic_setting.iconImage(fit: BoxFit.cover, size: 16),
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    onTap: () => const SettingScreen().launch(context),
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  16.height,
                  SettingItemWidget(
                    title: locale.socialMedia,
                    titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                    subTitle: '${locale.facebook}, ${locale.instagram}',
                    leading: ic_about.iconImage(fit: BoxFit.cover, size: 18),
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    onTap: () => const SocialMediaScreen().launch(context),
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  16.height,
                  SettingItemWidget(
                    title: locale.aboutApp,
                    titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                    subTitle:
                        '${locale.about}, ${locale.privacyPolicy}, ${locale.tC}',
                    leading: ic_help.iconImage(fit: BoxFit.cover, size: 16),
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    onTap: () => const AboutAppScreen().launch(context),
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  16.height,
                  SettingItemWidget(
                    title: locale.signIn,
                    titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                    subTitle: locale.signInYourAccount,
                    leading: ic_logout.iconImage(fit: BoxFit.cover, size: 14),
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    onTap: () {
                      doIfLoggedIn(context, () {
                        const DashboardScreen(pageIndex: 2)
                            .launch(context, isNewTask: true);
                      });
                    },
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ).visible(!appStore.isLoggedIn),
                  SettingItemWidget(
                    title: locale.logout,
                    titleTextStyle: boldTextStyle(size: LABEL_TEXT_SIZE),
                    subTitle: locale.logoutYourAccount,
                    leading: ic_logout.iconImage(fit: BoxFit.cover, size: 14),
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    onTap: () async {
                      bool? res = await showInDialog(
                        context,
                        contentPadding: EdgeInsets.zero,
                        transitionDuration: 100.milliseconds,
                        builder: (p0) {
                          return const LogoutConfirmationDialog();
                        },
                      );

                      if (res ?? false) {
                        await 50.milliseconds.delay;

                        appStore.setLoading(true);
                        String branchAddress = appStore.branchAddress;
                        String branchName = appStore.branchName;
                        int branchId = appStore.branchId;
                        String branchContactNumber =
                            appStore.branchContactNumber;

                        await logoutApi().then((value) async {
                          //
                        }).catchError((e) {
                          log(e.toString());
                        });

                        appStore.setLoading(false);

                        await appStore.setBranchAddress(branchAddress);
                        await appStore.setBranchId(branchId);
                        await appStore.setBranchName(branchName);
                        await appStore
                            .setBranchContactNumber(branchContactNumber);

                        if (context.mounted) {
                          const DashboardScreen().launch(context,
                              isNewTask: true,
                              pageRouteAnimation: PageRouteAnimation.Fade);
                        }
                      }
                    },
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ).visible(appStore.isLoggedIn),
                  30.height,
                  SnapHelperWidget<PackageInfoData>(
                    future: getPackageInfo(),
                    onSuccess: (data) {
                      return VersionInfoWidget(
                              prefixText: 'v', textStyle: primaryTextStyle())
                          .center();
                    },
                  ),
                ],
              ).paddingSymmetric(vertical: 24, horizontal: 16),
            ],
          ),
          Observer(
              builder: (context) =>
                  const LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
