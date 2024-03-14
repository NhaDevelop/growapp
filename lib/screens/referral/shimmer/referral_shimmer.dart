import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ReferralShimmer extends StatelessWidget {
  const ReferralShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20),
          ),
          child: const ShimmerWidget(height: 150, width: double.infinity),
        ),
        Transform.translate(
          offset: const Offset(0, -25),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Referral Code Details
                const ShimmerWidget(height: 240, width: double.infinity),
                24.height,

                // Reward History
                const ShimmerWidget(height: 20, width: 100),
                8.height,
                AnimatedListView(
                  itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return const ShimmerWidget(
                      height: 50,
                      width: double.infinity,
                    ).paddingBottom(8);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
