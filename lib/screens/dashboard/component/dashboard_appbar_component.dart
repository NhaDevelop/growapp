import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/screens/auth/view/sign_in_screen.dart';
import 'package:grow_tokyo_app/screens/points/view/points_screen.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/extensions/list_extensions.dart';
import 'package:grow_tokyo_app/utils/extensions/num_extensions.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';

class DashboardAppBarComponent extends StatefulWidget {
  final Widget? innerChild;
  final String? hintText;
  final Widget? positionWidget;
  final double? positionBottom;
  final VoidCallback? onTapSearch;

  const DashboardAppBarComponent(
      {super.key,
      this.innerChild,
      this.hintText,
      this.positionWidget,
      this.positionBottom,
      this.onTapSearch});

  @override
  State<DashboardAppBarComponent> createState() => _DashboardAppBarComponentState();
}

class _DashboardAppBarComponentState extends State<DashboardAppBarComponent> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        if (widget.innerChild != null)
          widget.innerChild!
        else
          Container(
            width: context.width(),
            padding: EdgeInsets.only(left: 21, right: 6, top: context.statusBarHeight),
            decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20),
                backgroundColor: primaryColor),
            child: Column(
              children: [
                16.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Flexible(
                          child: Observer(builder: (context) {
                            return Text(
                              appStore.isLoggedIn ? userStore.userFullName : 'Hello',
                              style: boldTextStyle(size: 18, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          }),
                        ),
                        Image.asset(ic_hi, height: 22, fit: BoxFit.cover),
                      ],
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Observer(builder: (context) {
                      final currentCountry = countryList()
                              .firstWhereOrNull((e) => e.countryCode == appStore.countryCode)
                              ?.name ??
                          '';
                      return Text(
                        currentCountry,
                        style: boldTextStyle(
                          size: 14,
                          color: Colors.white,
                        ),
                      );
                    }),
                    Observer(
                      builder: (context) => appStore.isLoggedIn
                          ? TextButton(
                              onPressed: () => const PointsScreen().launch(context),
                              child: Row(
                                children: [
                                  Image.asset(ic_crown, height: 20, width: 20, color: white),
                                  8.width,
                                  Text(
                                    userStore.pointAmount.formatAmount(),
                                    style: boldTextStyle(color: white, size: 20),
                                  ),
                                ],
                              ),
                            )
                          : TextButton(
                              onPressed: () => const SignInScreen().launch(context),
                              child:
                                  Text(locale.signIn, style: boldTextStyle(size: 14, color: white)),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        Positioned(
          bottom: widget.positionBottom,
          left: 20,
          right: 20,
          child: Container(
            width: context.width(),
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
            child: widget.positionWidget,
          ),
        )
      ],
    );
  }
}
