import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/modal_header.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponDetailsModal extends StatelessWidget {
  const CouponDetailsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: context.height() * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModalHeader(title: 'Coupon Details'),
            16.height,
            Container(
              color: const Color(0xFFF6F6F6),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: const Text('asdsa'),
            ),
            16.height,
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consequat nunc. Nulla facilisi. Sed ut lectus et libero volutpat aliquam',
              style: primaryTextStyle(size: 14),
            ).paddingSymmetric(horizontal: 24),
          ],
        ));
  }
}
