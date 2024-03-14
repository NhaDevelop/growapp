import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/shimmer_widget.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ShimmerWidget(
          height: 190,
          width: double.infinity,
        ),
        24.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
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
              Column(
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
