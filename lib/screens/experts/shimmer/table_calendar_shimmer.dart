import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class TableCalendarShimmer extends StatelessWidget {
  const TableCalendarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 8,
              child: ShimmerWidget(),
            ),
            const Center(child: ShimmerWidget(height: 20, width: 120)).expand(),
            const CircleAvatar(
              radius: 8,
              child: ShimmerWidget(),
            ),
          ],
        ).paddingSymmetric(horizontal: 32, vertical: 16),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          childAspectRatio: 0.85,
          children: List.generate(30, (index) {
            return ShimmerWidget(
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(8),
                  backgroundColor: Colors.grey.shade300,
                ),
                child: const ShimmerWidget(),
              ),
            );
          }),
        ),
      ],
    );
  }
}
