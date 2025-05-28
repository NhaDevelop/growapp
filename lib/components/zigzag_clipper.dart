import 'package:flutter/material.dart';

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    for (int i = 0; i <= size.width.toInt(); i += 10) {
      path.lineTo(i.toDouble(), size.height - 10);
      path.lineTo(i.toDouble() + 10, size.height);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
