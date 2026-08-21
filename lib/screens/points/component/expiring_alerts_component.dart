import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:nb_utils/nb_utils.dart';

class ExpiringAlertsComponent extends StatelessWidget {
  final PointData? points;

  const ExpiringAlertsComponent({super.key, this.points});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.expiringAlerts,
          style: boldTextStyle(size: 15),
        ).paddingSymmetric(horizontal: 16),
        10.height,
        Row(
          children: [
            Expanded(
              child: _buildAlertCard(
                context: context,
                iconColor: const Color(0xFFE53935),
                title: locale.expiringEndOfMonth,
                amount: points?.expiringEndMonth ?? 0.0,
              ),
            ),
            12.width,
            Expanded(
              child: _buildAlertCard(
                context: context,
                iconColor: const Color(0xFFFF6F00),
                title: locale.expiringNextMonth,
                amount: points?.expiringNextMonth ?? 0.0,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget _buildAlertCard({
    required BuildContext context,
    required Color iconColor,
    required String title,
    required double amount,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(14),
        backgroundColor: context.cardColor,
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.priority_high_rounded,
                  color: Colors.white,
                  size: 11,
                ),
              ),
              8.width,
              Text(
                title,
                style: boldTextStyle(
                  size: 12,
                  color: iconColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).expand(),
            ],
          ),
          12.height,
          Text(
            '${amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2)} P',
            style: boldTextStyle(size: 18),
          ),
        ],
      ),
    );
  }
}
