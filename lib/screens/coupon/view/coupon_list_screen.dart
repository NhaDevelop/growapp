import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/coupon/component/coupon_item_component.dart';
import 'package:grow_tokyo_app/screens/coupon/coupon_repository.dart';
import 'package:grow_tokyo_app/screens/coupon/model/coupon_list_response.dart';
import 'package:grow_tokyo_app/screens/coupon/shimmer/coupon_list_shimmer.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponListScreen extends StatefulWidget {
  const CouponListScreen({super.key});

  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  Future<List<CouponData>>? future;

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
        title: locale.coupon,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: SnapHelperWidget(
        future: future,
        loadingWidget: const CouponListShimmer(),
        onSuccess: (data) {
          return AnimatedListView(
            itemCount: data.length,
            onSwipeRefresh: _init,
            itemBuilder: (_, index) {
              final coupon = data[index];
              return CouponItemComponent(
                key: ValueKey(coupon.code),
                data: coupon,
              );
            },
          );
        },
      ),
    );
  }
}
