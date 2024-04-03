import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/coupon/view/coupon_list_screen.dart';
import 'package:grow_tokyo_app/screens/dashboard/component/inquiry_dialog.dart';
import 'package:grow_tokyo_app/screens/dashboard/fragment/notification_fragment.dart';
import 'package:grow_tokyo_app/screens/notifications/notification_repository.dart';
import 'package:grow_tokyo_app/screens/points/view/points_screen.dart';
import 'package:grow_tokyo_app/screens/referral/view/referral_screen.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardMenuComponent extends StatelessWidget {
  const DashboardMenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _MenuItem(
              icon: dashboard_menu_points,
              title: locale.points,
              onTap: () => doIfLoggedIn(
                context,
                () => const PointsScreen().launch(context),
              ),
            ).expand(),
            16.width,
            _MenuItem(
              icon: dashboard_menu_referral,
              title: locale.referral,
              onTap: () => doIfLoggedIn(
                context,
                () => const ReferralScreen().launch(context),
              ),
            ).expand(),
            16.width,
            _MenuItem(
              icon: dashboard_menu_coupon,
              title: locale.coupon,
              onTap: () => doIfLoggedIn(
                context,
                () => const CouponListScreen().launch(context),
              ),
            ).expand(),
          ],
        ),
        16.height,
        Row(
          children: [
            _MenuItem(
              icon: dashboard_menu_fbecsite,
              title: locale.fbEcSite,
              onTap: () {},
            ).expand(),
            16.width,
            _MenuItem(
              icon: dashboard_menu_inquiry,
              title: locale.inquiry,
              onTap: () => showDialog(
                context: context,
                builder: (context) => const InquiryDialog(),
              ),
            ).expand(),
            16.width,
            _NotificationMenuItem(
              icon: dashboard_menu_notifications,
              title: locale.notifications,
              onTap: () => doIfLoggedIn(
                context,
                () => const NotificationFragment().launch(context),
              ),
            ).expand(),
          ],
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String icon;
  final Widget iconIndicator;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconIndicator = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: boxDecorationRoundedWithShadow(
          12,
          shadowColor: black.withOpacity(0.03),
          blurRadius: 8,
          offset: const Offset(0, 6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(icon, width: 48, height: 48),
                Positioned(right: 0, top: 0, child: iconIndicator),
              ],
            ),
            8.height,
            Text(title, style: boldTextStyle(size: 14)),
          ],
        ),
      ),
    );
  }
}

class _NotificationMenuItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final String icon;

  const _NotificationMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<_NotificationMenuItem> createState() => _NotificationMenuItemState();
}

class _NotificationMenuItemState extends State<_NotificationMenuItem> {
  Future? future;
  int? count;

  @override
  void initState() {
    super.initState();
    getNotification(callBack: (totalCount) {
      count = totalCount;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MenuItem(
      icon: widget.icon,
      title: widget.title,
      onTap: widget.onTap,
      iconIndicator: Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: SizedBox(
          height: 16,
          width: 16,
          child: count == null
              ? null
              : FittedBox(
                  child: Text(count.toString(),
                      style: boldTextStyle(color: white))),
        ),
      ),
    );
  }
}
