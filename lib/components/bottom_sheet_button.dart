import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class BottomSheetButton extends StatelessWidget {
  final String text;
  final Widget? child;
  final Function onTap;

  const BottomSheetButton(
      {super.key, required this.text, this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: boxDecorationWithRoundedCorners(
            backgroundColor: primaryColor,
            borderRadius:
                radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: AppButton(text: text, onTap: onTap, child: child),
      ),
    );
  }
}
