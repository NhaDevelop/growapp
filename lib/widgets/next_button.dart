import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

/// A reusable Next button widget with consistent styling
class NextButton extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// Callback function when button is tapped
  final VoidCallback onTap;

  /// Optional custom text style
  final TextStyle? textStyle;

  /// Whether the button is enabled
  final bool enabled;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Whether to show a forward arrow icon
  final bool showArrow;

  /// Optional width for the button
  final double? width;

  /// Optional height for the button
  final double? height;

  /// Optional background color
  final Color? backgroundColor;

  const NextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.enabled = true,
    this.icon,
    this.showArrow = true,
    this.width,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      textStyle: textStyle ?? boldTextStyle(color: primaryColor),
      onTap: enabled ? onTap : null,
      width: width,
      height: height,
      color: backgroundColor ?? white,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: primaryColor, size: 20),
            8.width,
          ],
          Text(
            text,
            style: textStyle ?? boldTextStyle(color: primaryColor),
          ),
          if (showArrow) ...[
            8.width,
            Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
              size: 16,
            ),
          ],
        ],
      ),
    );
  }
}

/// A Next button positioned at the bottom of the screen
class BottomNextButton extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// Callback function when button is tapped
  final VoidCallback onTap;

  /// Optional custom text style
  final TextStyle? textStyle;

  /// Whether the button is enabled
  final bool enabled;

  /// Whether to show a forward arrow icon
  final bool showArrow;

  /// Optional background color for the container
  final Color? containerColor;

  /// Optional background color for the button
  final Color? buttonColor;

  const BottomNextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.enabled = true,
    this.showArrow = true,
    this.containerColor,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: containerColor ?? primaryColor,
          borderRadius: radiusOnly(
            topLeft: defaultRadius,
            topRight: defaultRadius,
          ),
        ),
        child: NextButton(
          text: text,
          onTap: onTap,
          textStyle: textStyle,
          enabled: enabled,
          showArrow: showArrow,
          backgroundColor: buttonColor,
        ),
      ),
    );
  }
}
