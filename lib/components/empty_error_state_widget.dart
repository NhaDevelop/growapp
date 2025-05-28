import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/generated/assets.dart';

class EmptyStateWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const EmptyStateWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.emptyGif,
      height: 150,
      repeat: ImageRepeat.repeat,
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const ErrorStateWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.errorGif,
      height: 110,
      repeat: ImageRepeat.repeat,
    );
  }
}
