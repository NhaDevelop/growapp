import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/coupon/component/coupon_item_component.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponListScreen extends StatelessWidget {
  const CouponListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.coupon,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: AnimatedListView(
          itemCount: 2,
          itemBuilder: (_, index) {
            return CouponItemComponent(key: ValueKey(index));
          }),
    );
  }
}
