import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class BlogPostListShimmer extends StatelessWidget {
  const BlogPostListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return const ShimmerWidget(
          height: 200,
          width: double.infinity,
        ).paddingBottom(16);
      },
    );
  }
}
