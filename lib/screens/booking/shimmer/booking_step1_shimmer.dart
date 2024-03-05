import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BookingStep1Shimmer extends StatelessWidget {
  const BookingStep1Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
      listAnimationType: ListAnimationType.None,
      children: [
        Column(
          children: [
            ShimmerWidget(height: 14, width: context.width() * 0.30),
            16.height,
            AnimatedListView(
              itemCount: 10,
              listAnimationType: ListAnimationType.None,
              itemBuilder: (context, index) {
                return ShimmerWidget(
                  child: Container(
                    width: context.width(),
                    padding:
                        const EdgeInsets.only(top: 48, left: 16, right: 16),
                    decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor),
                    child: ShimmerWidget(
                        height: 68, width: context.width() * 0.25),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
