import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:nb_utils/nb_utils.dart';

class LoaderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const LoaderWidget({super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/frezka_loader.gif',
      height: height ?? 150,
      width: width ?? 150,
      color: color ?? (appStore.isDarkMode ? Colors.white : Colors.black),
    ).center();
  }
}
