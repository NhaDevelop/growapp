import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/generated/assets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class NoBranchErrorWidget extends StatelessWidget {
  final String errorMessage;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;

  const NoBranchErrorWidget(
      {super.key,
      this.height,
      this.width,
      required this.errorMessage,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.errorGif, repeat: ImageRepeat.repeat, height: 300),
          Text(errorMessage,
                  style: boldTextStyle(size: 18), textAlign: TextAlign.center)
              .center(),
          16.height,
          TextButton(
            onPressed: () async {
              if (await isNetworkAvailable()) {
                // onPressed?.call();
                if (context.mounted) RestartAppWidget.init(context);
              } else {
                toast(locale.yourInternetIsNotWorking);
              }
            },
            child: Text(locale.reload),
          ),
        ],
      ),
    );
  }
}
