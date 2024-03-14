import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ReferralCodeDetailsShimmer extends StatelessWidget {
  const ReferralCodeDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const ShimmerWidget(height: 20, width: 150),
          8.height,
          const ShimmerWidget(height: 40, width: 100),
          24.height,
          Row(
            children: [
              const ShimmerWidget(height: 40, width: 100).expand(),
              16.width,
              const ShimmerWidget(height: 40, width: 100).expand(),
            ],
          ),
          24.height,
          Row(
            children: [
              const ShimmerWidget(height: 32, width: 32),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerWidget(height: 20, width: double.infinity),
                  8.height,
                  const ShimmerWidget(height: 20, width: 100),
                ],
              ).expand()
            ],
          )
        ],
      ),
    );
  }
}
