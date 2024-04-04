import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/screens/dashboard/shimmer/blog_component_shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ShimmerWidget(height: 90, width: double.infinity)
            .cornerRadiusWithClipRRectOnly(bottomLeft: 20, bottomRight: 20),
        Transform.translate(
          offset: const Offset(0, -25),
          child: Column(
            children: [
              const ShimmerWidget(
                height: 190,
                width: double.infinity,
              ),
              24.height,
              // Booking Button
              const ShimmerWidget(height: 50, width: double.infinity),
              24.height,

              //Dashboard Menu Component
              GridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: List.generate(6, (index) => const ShimmerWidget()),
              ),
              24.height,

              //Blog Component
              const BlogComponentShimmer(),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ],
    );
  }
}
