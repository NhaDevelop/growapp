import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grow_tokyo_app/components/zigzag_clipper.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/coupon/component/coupon_details_modal.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponItemComponent extends StatelessWidget {
  final bool selected;
  final VoidCallback? onTap;

  const CouponItemComponent({super.key, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipPath(
        clipper: ZigZagClipper(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            children: [
              Container(
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: const Color(0xFFEB5757).withOpacity(.2)),
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
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => const CouponDetailsModal(),
                    ),
                    child: Text(
                      locale.details,
                      style: primaryTextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ).paddingOnly(top: 4, bottom: 4, right: 8),
                  )
                ],
              ).expand(),
              16.width,
              onTap == null
                  ? 0.height
                  : Icon(
                      selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: context.iconColor,
                      size: 24,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
