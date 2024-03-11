import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DefaultCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const DefaultCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        backgroundColor: Colors.white,
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }
}
