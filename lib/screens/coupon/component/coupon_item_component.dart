import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/zigzag_clipper.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/coupon/component/coupon_details_modal.dart';
import 'package:grow_tokyo_app/screens/coupon/model/coupon_list_response.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponItemComponent extends StatelessWidget {
  final CouponData data;
  final bool selected;
  final VoidCallback? onTap;

  const CouponItemComponent({
    super.key,
    required this.data,
    this.selected = false,
    this.onTap,
  });

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
                  Text(data.name, style: boldTextStyle()),
                  4.height,
                  Text(
                    '${locale.validUntil} ${formatDate(data.validUntil.toString(), format: DateFormatConst.BOOK_DATE_FORMAT)}',
                    style: secondaryTextStyle(),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => CouponDetailsModal(data: data),
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
