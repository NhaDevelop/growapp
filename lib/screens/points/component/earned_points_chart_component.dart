import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:nb_utils/nb_utils.dart';

class EarnedPointsChartComponent extends StatefulWidget {
  final PointData? points;
  const EarnedPointsChartComponent({super.key, this.points});

  @override
  State<EarnedPointsChartComponent> createState() =>
      _EarnedPointsChartComponentState();
}

class _EarnedPointsChartComponentState
    extends State<EarnedPointsChartComponent> {
  int? selectedIndex;

  String _formatYAxis(double val) {
    if (val >= 1000) {
      final k = val / 1000;
      return '${k % 1 == 0 ? k.toStringAsFixed(0) : k.toStringAsFixed(1)}k';
    }
    return val.toStringAsFixed(0);
  }

  String _formatTooltip(double val) {
    // Format with comma separator like "27,000"
    if (val >= 1000) {
      final parts = val.toStringAsFixed(val % 1 == 0 ? 0 : 2).split('.');
      final intPart = parts[0];
      final buffer = StringBuffer();
      for (int i = 0; i < intPart.length; i++) {
        if (i > 0 && (intPart.length - i) % 3 == 0) buffer.write(',');
        buffer.write(intPart[i]);
      }
      if (parts.length > 1) buffer.write('.${parts[1]}');
      return buffer.toString();
    }
    return val % 1 == 0 ? val.toStringAsFixed(0) : val.toStringAsFixed(2);
  }

  String _formatCurrency(double val) {
    if (val.truncateToDouble() == val) return '${val.toStringAsFixed(0)} P';
    return '${val.toStringAsFixed(2)} P';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = appStore.isDarkMode;
    final history = widget.points?.monthlyHistory ?? [];

    final MonthlyPointHistory currentMonthData = history.isNotEmpty
        ? history.last
        : MonthlyPointHistory(month: 'Sep 2026', earned: 0, used: 0);

    // Max value for scale
    double maxDataVal = 0;
    for (final item in history) {
      maxDataVal = max(maxDataVal, max(item.earned, item.used));
    }

    // Clean rounded Y-axis max
    double yMax = 100;
    if (maxDataVal > 0) {
      if (maxDataVal <= 100) {
        yMax = 100;
      } else if (maxDataVal <= 500) {
        yMax = (maxDataVal / 100).ceil() * 100.0;
      } else if (maxDataVal <= 2000) {
        yMax = (maxDataVal / 500).ceil() * 500.0;
      } else if (maxDataVal <= 10000) {
        yMax = (maxDataVal / 2000).ceil() * 2000.0;
      } else {
        yMax = (maxDataVal / 5000).ceil() * 5000.0;
      }
    }

    // 7 Y-axis ticks from top to bottom
    const int yTicks = 7;
    final double tickStep = yMax / (yTicks - 1);
    final List<double> tickValues =
        List.generate(yTicks, (i) => yMax - i * tickStep);

    final selectedItem = (selectedIndex != null &&
            selectedIndex! >= 0 &&
            selectedIndex! < history.length)
        ? history[selectedIndex!]
        : null;

    final Color gridLineColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.grey.withValues(alpha: 0.18);
    final Color yLabelColor =
        isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final Color xLabelColor =
        isDark ? Colors.grey.shade400 : Colors.grey.shade700;
    final Color currentMonthLabelColor = const Color(0xFF22C55E);
    final Color defaultBarColor = const Color(0xFF4285F4);
    final Color selectedBarColor = const Color(0xFF1A5DF0);
    final Color currentMonthBarColor = const Color(0xFF22C55E);

    const double chartHeight = 180.0;
    const double yAxisWidth = 50.0;
    const double barAreaWidth = 36.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              color: const Color(0xFF16163F),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Earned Points History',
                      style: boldTextStyle(size: 13, color: Colors.white),
                    ).expand(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: currentMonthLabelColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: currentMonthLabelColor.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Text(
                        '● ${currentMonthData.month}',
                        style: boldTextStyle(
                            size: 10, color: currentMonthLabelColor),
                      ),
                    ),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    _statChip('Earned', currentMonthData.earned,
                        const Color(0xFF22C55E)),
                    12.width,
                    _statChip(
                        'Used', currentMonthData.used, const Color(0xFFEF4444)),
                  ],
                ),
              ],
            ),
          ),

          if (history.isEmpty)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                child: Text('No chart data available'),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 16, 12),
              child: Column(
                children: [
                  // ── Chart Area (tooltip floats inside as overlay) ────────
                  SizedBox(
                    height: chartHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Y-Axis Labels
                        SizedBox(
                          width: yAxisWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: tickValues
                                .map((v) => Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: Text(
                                        _formatYAxis(v),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: yLabelColor,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),

                        // Chart bars + grid + floating tooltip
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final drawH = constraints.maxHeight;
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // Horizontal grid lines
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      yTicks,
                                      (_) => Container(
                                        height: 1,
                                        color: gridLineColor,
                                      ),
                                    ),
                                  ),

                                  // Bars
                                  Positioned.fill(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children:
                                          history.asMap().entries.map((entry) {
                                        final i = entry.key;
                                        final item = entry.value;
                                        final isSelected = selectedIndex == i;
                                        final isCurrentMonth =
                                            i == history.length - 1;

                                        final pixH = item.earned > 0
                                            ? max(
                                                (item.earned / yMax) *
                                                    (drawH - 4),
                                                6.0)
                                            : (item.used > 0 ? 3.0 : 0.0);

                                        final barColor = isCurrentMonth
                                            ? currentMonthBarColor
                                            : (isSelected
                                                ? selectedBarColor
                                                : defaultBarColor);

                                        return GestureDetector(
                                          onTap: () => setState(() {
                                            selectedIndex =
                                                isSelected ? null : i;
                                          }),
                                          behavior: HitTestBehavior.opaque,
                                          child: SizedBox(
                                            width: barAreaWidth,
                                            height: drawH,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 250),
                                                curve: Curves.easeOut,
                                                width: isSelected ? 30 : 26,
                                                height: pixH,
                                                decoration: BoxDecoration(
                                                  color: barColor,
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(5),
                                                  ),
                                                  boxShadow: isSelected ||
                                                          isCurrentMonth
                                                      ? [
                                                          BoxShadow(
                                                            color: barColor
                                                                .withValues(
                                                                    alpha:
                                                                        0.45),
                                                            blurRadius: 8,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                          ),
                                                        ]
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),

                                  // ── Floating tooltip overlay (no layout shift) ──
                                  if (selectedItem != null)
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: AnimatedOpacity(
                                        opacity: 1.0,
                                        duration:
                                            const Duration(milliseconds: 180),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1E1E30),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withValues(alpha: 0.3),
                                                blurRadius: 12,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                selectedItem.month,
                                                style: boldTextStyle(
                                                    size: 12,
                                                    color: Colors.white),
                                              ).expand(),
                                              _tooltipChip(
                                                color: defaultBarColor,
                                                label:
                                                    'Earned: ${_formatTooltip(selectedItem.earned)}',
                                              ),
                                              if (selectedItem.used > 0) ...[
                                                8.width,
                                                _tooltipChip(
                                                  color:
                                                      const Color(0xFFEF4444),
                                                  label:
                                                      'Used: ${_formatTooltip(selectedItem.used)}',
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── X-Axis Labels ─────────────────────────────
                  8.height,
                  Row(
                    children: [
                      SizedBox(width: yAxisWidth),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: history.asMap().entries.map((entry) {
                            final i = entry.key;
                            final item = entry.value;
                            final isSelected = selectedIndex == i;
                            final isCurrentMonth = i == history.length - 1;

                            final labelColor = isSelected
                                ? selectedBarColor
                                : (isCurrentMonth
                                    ? currentMonthLabelColor
                                    : xLabelColor);

                            return GestureDetector(
                              onTap: () => setState(() {
                                selectedIndex = isSelected ? null : i;
                              }),
                              child: SizedBox(
                                width: barAreaWidth,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.month.split(' ').first,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight:
                                            (isSelected || isCurrentMonth)
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                        color: labelColor,
                                      ),
                                    ),
                                    if (isCurrentMonth) ...[
                                      3.height,
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: currentMonthLabelColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _statChip(String label, double val, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        5.width,
        Text(
          '$label: ${_formatCurrency(val)}',
          style: boldTextStyle(size: 11, color: color),
        ),
      ],
    );
  }

  Widget _tooltipChip({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2)),
        ),
        5.width,
        Text(
          label,
          style: boldTextStyle(size: 11, color: Colors.white),
        ),
      ],
    );
  }
}
