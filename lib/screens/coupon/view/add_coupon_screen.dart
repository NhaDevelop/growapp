import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/coupon/component/coupon_item_component.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class AddCouponScreen extends StatefulWidget {
  const AddCouponScreen({super.key});

  @override
  State<AddCouponScreen> createState() => _AddCouponScreenState();
}

class _AddCouponScreenState extends State<AddCouponScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: 'Add Coupon',
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: Stack(
        children: [
          AnimatedListView(
              itemCount: 2,
              itemBuilder: (_, index) {
                return CouponItemComponent(
                  key: ValueKey(index),
                  selected: index == _selected,
                  onTap: () => setState(() => _selected = index),
                );
              }),
          Positioned(
            bottom: 48,
            left: 16,
            right: 16,
            child: AppButton(
              text: locale.apply,
              color: context.primaryColor,
              textStyle: boldTextStyle(color: white),
              onTap: () => finish(context, _selected.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
