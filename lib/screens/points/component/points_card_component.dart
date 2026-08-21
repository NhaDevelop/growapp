import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:grow_tokyo_app/utils/extensions/num_extensions.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class PointsCardComponent extends StatelessWidget {
  final PointData? points;

  const PointsCardComponent({super.key, this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(16),
        backgroundColor: const Color(0xFF16163F),
      ),
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              points_banner_bg,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ).cornerRadiusWithClipRRect(16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    locale.membershipPoints.toUpperCase(),
                    style: primaryTextStyle(
                      size: 13,
                      color: white.withValues(alpha: 0.8),
                      weight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ).expand(),
                  Image.asset(
                    logo_long,
                    height: 22,
                    errorBuilder: (_, __, ___) => Text(
                      'grow',
                      style: boldTextStyle(color: white, size: 16),
                    ),
                  ),
                ],
              ),
              16.height,
              Row(
                children: [
                  Image.asset(
                    ic_crown,
                    height: 26,
                    width: 26,
                    color: Colors.amber,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                      size: 26,
                    ),
                  ),
                  10.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${(points?.amount ?? userStore.pointToAmount).formatAmount()} P',
                        style: boldTextStyle(size: 26, color: white),
                      ),
                      4.height,
                      Text(
                        locale.equivalentToX(
                          (points?.equivalentAmount ?? points?.amount ?? 0)
                              .formatAmount(),
                        ),
                        style: secondaryTextStyle(
                          size: 12,
                          color: white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ).expand(),
                ],
              ),
              12.height,
            ],
          ).paddingAll(20),
        ],
      ),
    );
  }
}
