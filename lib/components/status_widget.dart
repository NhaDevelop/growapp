import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class StatusWidget extends StatelessWidget {
  final String? text;
  final Color? color;

  const StatusWidget({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.center,
      decoration: boxDecorationDefault(
        color: color?.withAlpha(20),
        boxShadow: [const BoxShadow(color: Colors.transparent)],
      ),
      child: Text(text ?? '', style: boldTextStyle(color: color, size: 14)),
    );
  }
}
