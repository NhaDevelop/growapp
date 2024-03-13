import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:grow_tokyo_app/components/zigzag_clipper.dart';
import 'package:nb_utils/nb_utils.dart';

class CouponListShimmer extends StatelessWidget {
  const CouponListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemBuilder: (_, index) {
        return ClipPath(
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
                  child: ShimmerWidget(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: context.cardColor,
                      ),
                    ),
                  ),
                ),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget(
                      child: Container(
                        height: 20,
                        width: 100,
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: context.cardColor,
                        ),
                      ),
                    ),
                    4.height,
                    ShimmerWidget(
                      child: Container(
                        height: 20,
                        width: 200,
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: context.cardColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: ShimmerWidget(
                        child: Container(
                          height: 20,
                          width: 50,
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: context.cardColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ).expand(),
                16.width,
              ],
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }
}
