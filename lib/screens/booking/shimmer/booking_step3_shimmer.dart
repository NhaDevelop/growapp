import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class BookingStep3Shimmer extends StatelessWidget {
  const BookingStep3Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: context.width(),
      margin: const EdgeInsets.only(bottom: 50),
      decoration: boxDecorationWithRoundedCorners(
          backgroundColor: context.cardColor, borderRadius: radius()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(height: 12, width: context.width() * 0.20),
              10.height,
              AnimatedWrap(
                spacing: 16,
                runSpacing: 16,
                itemCount: 12,
                listAnimationType: ListAnimationType.None,
                itemBuilder: (p0, p1) {
                  return ShimmerWidget(
                      height: 28, width: context.width() / 3 - 35);
                },
              ),
            ],
          ),
          20.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(height: 12, width: context.width() * 0.20),
              10.height,
              AnimatedWrap(
                spacing: 16,
                runSpacing: 16,
                itemCount: 12,
                listAnimationType: ListAnimationType.None,
                itemBuilder: (p0, p1) {
                  return ShimmerWidget(
                      height: 28, width: context.width() / 3 - 35);
                },
              ),
            ],
          ),
          20.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(height: 12, width: context.width() * 0.20),
              10.height,
              AnimatedWrap(
                spacing: 16,
                runSpacing: 16,
                itemCount: 12,
                listAnimationType: ListAnimationType.None,
                itemBuilder: (p0, p1) {
                  return ShimmerWidget(
                      height: 28, width: context.width() / 3 - 35);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
