import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BookingStep1Shimmer extends StatelessWidget {
  const BookingStep1Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerWidget(height: 14, width: context.width() * 0.30),
        AnimatedListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              width: context.width(),
              padding: const EdgeInsets.all(16),
              decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: context.cardColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(radius: 29, child: ShimmerWidget()),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWidget(height: 16, width: context.width() * 0.2),
                      8.height,
                      ShimmerWidget(height: 12, width: context.width() * 0.2),
                    ],
                  ).expand(),
                  16.width,
                  const CircleAvatar(radius: 10, child: ShimmerWidget())
                ],
              ),
            ).paddingOnly(top: 16);
          },
        ).expand(),
      ],
    ).paddingOnly(top: 70);
  }
}
