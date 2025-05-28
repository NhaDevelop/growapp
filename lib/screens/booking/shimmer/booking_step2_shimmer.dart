import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BookingStep2Shimmer extends StatelessWidget {
  const BookingStep2Shimmer({super.key});

  double get randomWidth {
    final random = Random();
    return 50 + random.nextInt(50).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerWidget(height: 14, width: context.width() * 0.30),
        16.height,
        AnimatedListView(
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (_, __) {
            return Container(
              decoration: boxDecorationDefault(),
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 20, width: randomWidth),
                  const CircleAvatar(radius: 8, child: ShimmerWidget()),
                ],
              ),
            ).paddingOnly(top: 16);
          },
        ).expand(),
      ],
    ).paddingOnly(left: 20, right: 20, top: 70, bottom: 20);
  }
}
