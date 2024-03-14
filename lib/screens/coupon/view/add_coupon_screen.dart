import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/coupon/component/coupon_item_component.dart';
import 'package:grow_tokyo_app/screens/coupon/coupon_repository.dart';
import 'package:grow_tokyo_app/screens/coupon/model/coupon_list_response.dart';
import 'package:grow_tokyo_app/screens/coupon/shimmer/coupon_list_shimmer.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class AddCouponScreen extends StatefulWidget {
  const AddCouponScreen({super.key});

  @override
  State<AddCouponScreen> createState() => _AddCouponScreenState();
}

class _AddCouponScreenState extends State<AddCouponScreen> {
  Future<List<CouponData>>? future;
  CouponData? _selected;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    future = getCouponList();
  }

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
          SnapHelperWidget(
            future: future,
            loadingWidget: const CouponListShimmer(),
            onSuccess: (data) {
              return AnimatedListView(
                itemCount: data.length,
                onSwipeRefresh: _init,
                itemBuilder: (_, index) {
                  final coupon = data[index];
                  return CouponItemComponent(
                    key: ValueKey(index),
                    data: coupon,
                    selected: coupon.code == _selected?.code,
                    onTap: () => setState(() => _selected = coupon),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 48,
            left: 16,
            right: 16,
            child: AppButton(
              text: locale.apply,
              color: context.primaryColor,
              textStyle: boldTextStyle(color: white),
              onTap: () => finish(context, _selected),
            ),
          ),
        ],
      ),
    );
  }
}
