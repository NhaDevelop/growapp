import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class SocialMediaShimmer extends StatelessWidget {
  const SocialMediaShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemCount: 2,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radius(12),
            backgroundColor: context.cardColor,
          ),
          child: Row(
            children: [
              const CircleAvatar(radius: 8, child: ShimmerWidget()),
              16.width,
              const ShimmerWidget(height: 18, width: 200),
            ],
          ),
        );
      },
    );
  }
}
