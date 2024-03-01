import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
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
              onTap: onTap,
            ).expand(),
            16.width,
            _MenuItem(
              icon: dashboard_menu_referral,
              title: locale.referral,
              onTap: onTap,
            ).expand(),
            16.width,
            _MenuItem(
              icon: dashboard_menu_coupon,
              title: locale.coupon,
              onTap: onTap,
            ).expand(),
          ],
        ),
        16.height,
        Row(
          children: [
            _MenuItem(
              icon: dashboard_menu_fbecsite,
              title: locale.fbEcSite,
              onTap: onTap,
            ).expand(),
            16.width,
            _MenuItem(
              icon: dashboard_menu_inquiry,
              title: locale.inquiry,
              onTap: onTap,
            ).expand(),
            16.width,
            _MenuItem(
              icon: dashboard_menu_notifications,
              title: locale.notifications,
              onTap: onTap,
            ).expand(),
          ],
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final Function onTap;
  final String icon;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: boxDecorationRoundedWithShadow(
        12,
        shadowColor: const Color(0xFF000000).withOpacity(0.03),
        blurRadius: 8,
        offset: const Offset(0, 6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 48, height: 48),
          8.height,
          Text(title, style: boldTextStyle(size: 14)),
        ],
      ),
    );
  }
}
