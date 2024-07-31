import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/select_country_dialog.dart';
import 'package:grow_tokyo_app/components/select_language_dialog.dart';
import 'package:grow_tokyo_app/screens/auth/view/sign_in_screen.dart';
import 'package:grow_tokyo_app/screens/dashboard/dashboard_repository.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/voice_search_component.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
// import '../../product/view/product_dashboard_screen.dart';
import '../fragment/booking_fragment.dart';
import '../fragment/home_fragment.dart';
import '../fragment/profile_fragment.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  const DashboardScreen({super.key, this.pageIndex = 0});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  int currentPosition = 0;

  List<Widget> fragmentList = [
    const HomeFragment(),
    Observer(
        builder: (context) => appStore.isLoggedIn
            ? const BookingFragment()
            : const SignInScreen(isFromDashboard: true)),
    // const ProductScreen(),
    const ProfileFragment(),
  ];

  @override
  void initState() {
    currentPosition = widget.pageIndex;
    if (getIntAsync(THEME_MODE_INDEX) == ThemeConst.THEME_MODE_SYSTEM) {
      WidgetsBinding.instance.addObserver(this);
    }
    super.initState();
    init();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ///SelectCountry Dialog
      if (!appStore.isCountrySelected) {
        if (!appStore.isCountrySelected && mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const SelectCountryDialog(),
          ).then((value) => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const SelectLanguageDialog(),
              ));
        }
      }

      getSocialUrls().then(appStore.setSocialData).catchError(onError);

      /// ForceUpdate Dialog
      if (mounted) showForceUpdateDialog(context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangePlatformBrightness() {
    if (getIntAsync(THEME_MODE_INDEX) == ThemeConst.THEME_MODE_SYSTEM) {
      appStore.setDarkMode(
          MediaQuery.of(context).platformBrightness == Brightness.light);
    }
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      message: locale.pressBackAgainToExitApp,
      child: Scaffold(
        body: fragmentList[currentPosition],
        bottomNavigationBar: Blur(
          blur: 30,
          borderRadius: radius(0),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: context.primaryColor.withOpacity(0.02),
              indicatorColor: context.primaryColor.withOpacity(0.1),
              labelTextStyle:
                  WidgetStateProperty.all(primaryTextStyle(size: 12)),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: NavigationBar(
              selectedIndex: currentPosition,
              onDestinationSelected: (index) {
                currentPosition = index;
                setState(() {});
              },
              destinations: [
                bottomTab(
                  iconData: ic_unselected_home.iconImage(
                      color: appTextSecondaryColor, size: 18),
                  activeIconData: ic_selected_home.iconImage(
                      color: context.primaryColor, size: 18),
                  tabName: locale.home,
                ),
                bottomTab(
                  iconData: ic_unselected_booking.iconImage(
                      color: appTextSecondaryColor, size: 18),
                  activeIconData: ic_selected_booking.iconImage(
                      color: context.primaryColor, size: 18),
                  tabName: locale.myBooking,
                ),
                // bottomTab(
                //   iconData: ic_unselected_shop.iconImage(
                //       color: appTextSecondaryColor, size: 20),
                //   activeIconData: ic_selected_shop.iconImage(
                //       color: context.primaryColor, size: 20),
                //   tabName: locale.shop,
                // ),
                Observer(builder: (context) {
                  return bottomTab(
                    iconData: appStore.isLoggedIn
                        ? CachedImageWidget(
                            url: userStore.userProfileImage.validate(),
                            height: 26,
                            fit: BoxFit.cover,
                            width: 26,
                            radius: 30,
                            child: ic_unselected_profile.iconImage(
                                color: appTextSecondaryColor, size: 18),
                          )
                        : ic_unselected_profile.iconImage(
                            color: appTextSecondaryColor, size: 18),
                    activeIconData: appStore.isLoggedIn
                        ? CachedImageWidget(
                            url: userStore.userProfileImage.validate(),
                            height: 26,
                            fit: BoxFit.cover,
                            width: 26,
                            radius: 30,
                            child: ic_selected_profile.iconImage(
                                color: context.primaryColor, size: 18),
                          )
                        : ic_selected_profile.iconImage(
                            color: context.primaryColor, size: 18),
                    tabName: locale.user,
                  );
                }),
              ],
            ),
          ),
        ),
        bottomSheet: Observer(builder: (context) {
          return const VoiceSearchComponent()
              .visible(appStore.isSpeechActivated);
        }),
      ),
    );
  }
}
