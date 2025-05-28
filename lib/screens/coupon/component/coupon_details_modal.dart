import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/modal_header.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/coupon/model/coupon_list_response.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponDetailsModal extends StatelessWidget {
  final CouponData data;
  const CouponDetailsModal({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ModalHeader(title: data.name),
        Container(
          color: const Color(0xFFF6F6F6),
          width: context.width(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.name, style: boldTextStyle(size: 18)),
              4.height,
              RichTextWidget(list: [
                TextSpan(
                    text: locale.discountCode,
                    style: secondaryTextStyle(size: 14)),
                const TextSpan(text: ': '),
                TextSpan(
                  text: data.code,
                  style: primaryTextStyle(size: 14, weight: FontWeight.w500),
                )
              ]),
              4.height,
              RichTextWidget(list: [
                TextSpan(
                    text: locale.validUntil,
                    style: secondaryTextStyle(size: 14)),
                const TextSpan(text: ': '),
                TextSpan(
                  text: formatDate(data.validUntil.toString(),
                      format: DateFormatConst.BOOK_DATE_FORMAT),
                  style: primaryTextStyle(size: 14, weight: FontWeight.w500),
                )
              ]),
            ],
          ),
        ),
        16.height,
        Text(
          data.description,
          style: primaryTextStyle(size: 14),
        ).paddingSymmetric(horizontal: 24),
        64.height,
      ],
    );
  }
}
