import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/shimmer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class AboutAppShimmer extends StatelessWidget {
  const AboutAppShimmer({super.key});

  double get randomWidth {
    final random = Random();
    return 80 + random.nextInt(80).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (_, index) {
        return Container(
          decoration: boxDecorationDefault(),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(radius: 8, child: ShimmerWidget()),
              16.width,
              ShimmerWidget(height: 18, width: randomWidth),
            ],
          ),
        ).paddingOnly(top: 16);
      },
    );
  }
}
