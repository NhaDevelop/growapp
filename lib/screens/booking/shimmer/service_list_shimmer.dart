import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceListShimmer extends StatelessWidget {
  const ServiceListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedWrap(
      runSpacing: 16,
      itemCount: 5,
      listAnimationType: ListAnimationType.None,
      itemBuilder: (p0, p1) {
        return Row(
          children: [
            ShimmerWidget(
              child: Container(
                height: 50,
                width: 50,
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: context.cardColor,
                  borderRadius: radius(defaultRadius),
                ),
              ),
            ),
            8.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(
                  child: Container(
                    height: 20,
                    width: 100,
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: context.cardColor,
                      borderRadius: radius(defaultRadius),
                    ),
                  ),
                ),
                8.height,
                ShimmerWidget(
                  child: Container(
                    height: 20,
                    width: 200,
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: context.cardColor,
                      borderRadius: radius(defaultRadius),
                    ),
                  ),
                ),
              ],
            ).expand(),
            Checkbox(
              value: false,
              onChanged: (value) {},
            )
          ],
        );
      },
    );
  }
}
