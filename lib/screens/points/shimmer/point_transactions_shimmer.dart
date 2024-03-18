import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class PointTransactionsShimmer extends StatelessWidget {
  const PointTransactionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: boxDecorationDefault(),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerWidget(height: 18, width: 100),
                  4.height,
                  const ShimmerWidget(height: 18, width: 150),
                  2.height,
                  const ShimmerWidget(height: 18, width: 100),
                ],
              ).expand(),
              16.width,
              const ShimmerWidget(height: 20, width: 50),
            ],
          ),
        );
      },
    );
  }
}
