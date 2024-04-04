import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class BlogComponentShimmer extends StatelessWidget {
  const BlogComponentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            ShimmerWidget(height: 20, width: 100),
            Spacer(),
            ShimmerWidget(height: 20, width: 100),
          ],
        ),
        8.height,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              3,
              (index) => const ShimmerWidget(
                height: 150,
                width: 270,
              ).paddingOnly(right: 16),
            ),
          ),
        ),
      ],
    );
  }
}
