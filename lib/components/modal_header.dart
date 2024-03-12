import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ModalHeader extends StatelessWidget {
  final String title;

  const ModalHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: boldTextStyle(size: 18)),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            finish(context);
          },
        ),
      ],
    ).paddingOnly(left: 24, right: 16, top: 8, bottom: 16);
  }
}
