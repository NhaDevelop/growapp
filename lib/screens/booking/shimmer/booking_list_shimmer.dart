import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingListShimmer extends StatelessWidget {
  const BookingListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 20,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 40, bottom: 12),
      shrinkWrap: true,
      itemBuilder: (p0, p1) {
        return Container(
          width: context.width(),
          margin: const EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget(
                child: Container(
                  height: 24,
                  width: 60,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 26),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: context.cardColor,
                    borderRadius: radiusOnly(topLeft: defaultRadius),
                  ),
                ),
              ),
              12.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerWidget(height: 75, width: 75),
                      12.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget(height: 16, width: context.width()),
                          8.height,
                          ShimmerWidget(height: 12, width: context.width()),
                          10.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const ShimmerWidget(height: 14, width: 14),
                                  8.width,
                                  ShimmerWidget(
                                      height: 16,
                                      width: context.width() * 0.15),
                                ],
                              ),
                              Row(
                                children: [
                                  const ShimmerWidget(height: 14, width: 14),
                                  8.width,
                                  ShimmerWidget(
                                      height: 16,
                                      width: context.width() * 0.15),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ).expand(),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  Column(
                    children: [
                      Divider(color: context.dividerColor),
                      6.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const ShimmerWidget(height: 14, width: 14),
                              8.width,
                              ShimmerWidget(
                                  height: 16, width: context.width() * 0.15),
                            ],
                          ),
                          Row(
                            children: [
                              const ShimmerWidget(height: 14, width: 14),
                              8.width,
                              ShimmerWidget(
                                  height: 16, width: context.width() * 0.15),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 8),
                  ShimmerWidget(
                    child: Container(
                      height: 45,
                      width: context.width(),
                      decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: context.cardColor),
                    ),
                  ).paddingSymmetric(horizontal: 16, vertical: 8),
                  8.height,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
