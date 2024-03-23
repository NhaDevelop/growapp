import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/screens/branch/model/branch_configuration_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';

class SlotItemComponent extends StatelessWidget {
  final SlotData timeSlot;
  final bool isSelected;
  final DateTime selectedHorizontalDate;

  final VoidCallback? onTap;

  const SlotItemComponent(
      {super.key,
      required this.timeSlot,
      required this.isSelected,
      this.onTap,
      required this.selectedHorizontalDate});

  @override
  Widget build(BuildContext context) {
    bool isSlotAvailable = timeSlot.slotAvailability(selectedHorizontalDate);
    return GestureDetector(
      onTap: () async {
        onTap?.call();
      },
      child: Container(
        width: context.width() / 3 - 35,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(),
          border: Border.all(
            color: isSlotAvailable ? indicatorColor : Colors.transparent,
          ),
          backgroundColor: !isSlotAvailable
              ? Colors.grey.shade200
              : isSelected
                  ? indicatorColor
                  : transparentColor,
        ),
        child: Marquee(
          child: Text(
            formatOnlyTime(context, startTime: timeSlot.startTime),
            style: boldTextStyle(
              size: 12,
              color: !isSlotAvailable
                  ? grey
                  : isSelected
                      ? Colors.white
                      : textSecondaryColorGlobal,
              decoration: isSlotAvailable ? null : TextDecoration.lineThrough,
            ),
          ),
        ),
      ),
    );
  }
}
