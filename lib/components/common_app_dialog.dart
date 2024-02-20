import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class CommonAppDialog extends StatefulWidget {
  final String? icon;
  final String? title;
  final String? subTitle;
  final String? buttonText;
  final Function? onTap;
  final bool isQuickBooking;

  const CommonAppDialog(
      {super.key,
      this.icon,
      this.title,
      this.subTitle,
      this.buttonText,
      this.onTap,
      this.isQuickBooking = false});

  @override
  State<CommonAppDialog> createState() => _CommonAppDialogState();
}

class _CommonAppDialogState extends State<CommonAppDialog> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: context.cardColor,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
                backgroundColor: indicatorColor,
                radius: 50,
                child: Image.asset(widget.icon ?? ic_confetti_ball,
                    fit: BoxFit.cover, height: 50)),
            16.height,
            Text(widget.title.validate(),
                style: boldTextStyle(size: LABEL_TEXT_SIZE),
                textAlign: TextAlign.center),
            16.height,
            Text(widget.subTitle.validate(),
                    style: secondaryTextStyle(size: 14),
                    textAlign: TextAlign.center)
                .center(),
            24.height,
            if (widget.isQuickBooking)
              Row(
                children: [
                  AppButton(
                    color: context.cardColor,
                    width: context.width(),
                    onTap: () {
                      finish(context);
                    },
                    child: Text(locale.cancel, style: boldTextStyle()),
                  ).expand(),
                  16.width,
                  AppButton(
                    color: secondaryColor,
                    width: context.width(),
                    onTap: widget.onTap,
                    child: Text(widget.buttonText.validate(),
                        style: boldTextStyle(color: white)),
                  ).expand(),
                ],
              )
            else
              AppButton(
                color: secondaryColor,
                width: context.width(),
                onTap: widget.onTap,
                child: Text(widget.buttonText.validate(),
                    style: boldTextStyle(color: white)),
              ),
          ],
        ),
      ),
    );
  }
}
