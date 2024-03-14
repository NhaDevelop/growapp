import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ReferralTransactionsShimmer extends StatelessWidget {
  const ReferralTransactionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFF27AE60),
              child: ShimmerWidget(),
            ),
            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerWidget(height: 20, width: 100),
                8.height,
                const ShimmerWidget(height: 20, width: 150),
              ],
            ).expand(),
            16.width,
            const ShimmerWidget(height: 20, width: 50),
          ],
        ).paddingOnly(bottom: 16);
      },
    );
  }
}
