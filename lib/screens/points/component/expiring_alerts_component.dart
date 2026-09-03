import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:nb_utils/nb_utils.dart';

class ExpiringAlertsComponent extends StatelessWidget {
  final PointData? points;
  const ExpiringAlertsComponent({super.key, this.points});

  String _formatVal(double val) {
    if (val.truncateToDouble() == val) {
      return '${val.toStringAsFixed(0)} P';
    }
    return '${val.toStringAsFixed(2)} P';
  }

  @override
  Widget build(BuildContext context) {
    final expThisMonth = points?.expiringThisMonth ?? 0.0;
    final expNextMonth = points?.expiringNextMonth ?? 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expiring Alerts',
            style: boldTextStyle(size: 15),
          ),
          12.height,
          Row(
            children: [
              // Ends This Month
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: boxDecorationWithRoundedCorners(
                    borderRadius: BorderRadius.circular(14),
                    backgroundColor: context.cardColor,
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.15),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.error_rounded,
                            color: Colors.redAccent,
                            size: 18,
                          ),
                          6.width,
                          Expanded(
                            child: Text(
                              'Ends This Month',
                              style: boldTextStyle(
                                size: 12,
                                color: Colors.redAccent,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      10.height,
                      Text(
                        _formatVal(expThisMonth),
                        style: boldTextStyle(size: 18),
                      ),
                    ],
                  ),
                ),
              ),
              12.width,
              // Ends Next Month
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: boxDecorationWithRoundedCorners(
                    borderRadius: BorderRadius.circular(14),
                    backgroundColor: context.cardColor,
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.error_rounded,
                            color: Colors.orange,
                            size: 18,
                          ),
                          6.width,
                          Expanded(
                            child: Text(
                              'Ends Next Month',
                              style: boldTextStyle(
                                size: 12,
                                color: Colors.orange.shade800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      10.height,
                      Text(
                        _formatVal(expNextMonth),
                        style: boldTextStyle(size: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
