import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class ViewAllServiceShimmer extends StatelessWidget {
  const ViewAllServiceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      padding: const EdgeInsets.only(top: 25, bottom: 80),
      crossAxisAlignment: CrossAxisAlignment.start,
      listAnimationType: ListAnimationType.None,
      children: [
        /// Subcategory UI
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            ShimmerWidget(height: 16, width: context.width() * 0.25).paddingLeft(16),
            8.height,
            HorizontalList(
              itemCount: 5,
              runSpacing: 16,
              spacing: 16,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              itemBuilder: (context, index) {
                return Container(
                  width: context.width() / 3 - 20,
                  padding: EdgeInsets.zero,
                  decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                  child: Column(
                    children: [
                      ShimmerWidget(height: 85, width: context.width() / 3 - 20),
                      ShimmerWidget(height: 10, width: context.width() * 0.15).paddingSymmetric(vertical: 8, horizontal: 8),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        16.height,

        /// Services UI
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            ShimmerWidget(height: 16, width: context.width() * 0.25),
            16.height,
            AnimatedListView(
              itemCount: 20,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                return Container(
                  decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
                  padding: const EdgeInsets.only(left: 16, right: 8, top: 16, bottom: 16),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ShimmerWidget(height: 70, width: 70),
                          8.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerWidget(height: 16, width: context.width() * 0.25),
                              8.height,
                              ShimmerWidget(height: 14, width: context.width() * 0.25),
                            ],
                          ).expand(),
                        ],
                      ).expand(),
                      16.width,
                      Row(
                        children: [
                          ShimmerWidget(height: 20, width: context.width() * 0.10),
                          8.width,
                          const ShimmerWidget(height: 20, width: 20),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
