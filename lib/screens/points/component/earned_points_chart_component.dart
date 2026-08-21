import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:nb_utils/nb_utils.dart';

class EarnedPointsChartComponent extends StatelessWidget {
  final List<MonthlyPointHistory> history;

  const EarnedPointsChartComponent({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    final displayHistory = history.isEmpty
        ? _buildDefaultHistory()
        : (history.length > 6 ? history.sublist(history.length - 6) : history);

    final currentMonth = displayHistory.isNotEmpty
        ? displayHistory.last
        : MonthlyPointHistory(month: '', earned: 0, used: 0);

    final maxVal = displayHistory.fold<double>(
      0.0,
      (prev, element) => max(prev, max(element.earned, element.used)),
    );
    final chartMax = maxVal > 0 ? (maxVal * 1.2).ceilToDouble() : 100.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(16),
        backgroundColor: context.cardColor,
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale.earnedPointsHistory,
            style: boldTextStyle(size: 14),
          ).paddingAll(16),
          // Dark Summary Banner Header
          Container(
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.circular(12),
              backgroundColor: const Color(0xFF141738),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${locale.currentMonthSummary}: ${currentMonth.month}',
                  style: boldTextStyle(size: 13, color: Colors.white),
                ),
                8.height,
                Row(
                  children: [
                    Text(
                      'Earned: ${currentMonth.earned.toStringAsFixed(currentMonth.earned.truncateToDouble() == currentMonth.earned ? 0 : 2)} P',
                      style: boldTextStyle(
                        size: 13,
                        color: const Color(0xFF00E676),
                      ),
                    ),
                    24.width,
                    Text(
                      'Used: ${currentMonth.used.toStringAsFixed(currentMonth.used.truncateToDouble() == currentMonth.used ? 0 : 2)} P',
                      style: boldTextStyle(
                        size: 13,
                        color: const Color(0xFFFF5252),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          16.height,
          // Bar Chart Area
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis Labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chartMax.toStringAsFixed(0),
                      style: secondaryTextStyle(size: 10),
                    ),
                    Text(
                      (chartMax * 0.66).toStringAsFixed(0),
                      style: secondaryTextStyle(size: 10),
                    ),
                    Text(
                      (chartMax * 0.33).toStringAsFixed(0),
                      style: secondaryTextStyle(size: 10),
                    ),
                    Text(
                      '0',
                      style: secondaryTextStyle(size: 10),
                    ),
                  ],
                ).paddingOnly(bottom: 22, right: 8),
                // Chart Bars Area
                Expanded(
                  child: Stack(
                    children: [
                      // Horizontal grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) => Divider(
                            height: 1,
                            thickness: 0.8,
                            color: Colors.grey.withValues(alpha: 0.15),
                          ),
                        ),
                      ).paddingOnly(bottom: 22),
                      // Bars Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: displayHistory.map((item) {
                          final double heightFactor = chartMax > 0
                              ? (item.earned / chartMax).clamp(0.02, 1.0)
                              : 0.02;
                          final isLatestRatio = item == displayHistory.last;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 28,
                                height: 110 * heightFactor,
                                decoration: boxDecorationWithRoundedCorners(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  backgroundColor: isLatestRatio
                                      ? const Color(0xFF2979FF)
                                      : Colors.grey.withValues(alpha: 0.3),
                                ),
                              ),
                              8.height,
                              Text(
                                item.shortMonth,
                                style: secondaryTextStyle(
                                  size: 11,
                                  color: isLatestRatio
                                      ? context.iconColor
                                      : textSecondaryColorGlobal,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
          ),
          12.height,
        ],
      ),
    );
  }

  List<MonthlyPointHistory> _buildDefaultHistory() {
    final monthNames = ['Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'];
    return monthNames
        .map((m) => MonthlyPointHistory(month: '$m 2026', earned: 0, used: 0))
        .toList();
  }
}
