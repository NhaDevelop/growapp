import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../fragment/notification_fragment.dart';

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
  State<DashboardAppBarComponent> createState() =>
      _DashboardAppBarComponentState();
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
            height: 190,
            padding: EdgeInsets.only(
                left: 21, right: 6, top: context.statusBarHeight),
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
                    Observer(builder: (context) {
                      return Text(
                        appStore.isLoggedIn
                            ? '${locale.hey}, ${userStore.userFullName}'
                            : locale.helloGuest,
                        style: boldTextStyle(size: 18, color: Colors.white),
                      );
                    }),
                    Image.asset(ic_hi, height: 22, fit: BoxFit.cover),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        doIfLoggedIn(context, () {
                          const NotificationFragment().launch(context);
                        });
                      },
                      icon: ic_unselected_bell.iconImage(
                          color: Colors.white, size: 20),
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
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            child: widget.positionWidget,
          ),
        )
      ],
    );
  }
}
