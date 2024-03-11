import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/images.dart';
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
                return _Item(
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
              text: 'Apply',
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

class _Item extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const _Item({super.key, this.selected = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor:
                            const Color(0xFFEB5757).withOpacity(.2)),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(coupon, height: 20, width: 20),
                  ),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Coupon Code', style: boldTextStyle()),
                      4.height,
                      Text('Get 20% off on your first booking',
                          style: secondaryTextStyle()),
                    ],
                  ).expand(),
                  16.width,
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: context.iconColor,
                    size: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
