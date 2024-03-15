import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class PointsCardComponent extends StatelessWidget {
  final double points;
  const PointsCardComponent({super.key, this.points = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(16),
        decorationImage: const DecorationImage(
          image: AssetImage(points_banner_bg),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                locale.membershipPoints.toUpperCase(),
                style: primaryTextStyle(
                    size: 14, color: white, weight: FontWeight.w500),
              ).expand(),
              Image.asset(logo_long, height: 24),
            ],
          ),
          16.height,
          Row(
            children: [
              Image.asset(ic_crown, height: 24, color: white),
              8.width,
              Text(
                points.toString(),
                style: boldTextStyle(size: 24, color: white),
              )
            ],
          ),
          16.height,
        ],
      ),
    );
  }
}
