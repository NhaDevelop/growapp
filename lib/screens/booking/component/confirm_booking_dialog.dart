import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/utils/colors.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';

class ConfirmBookingDialog extends StatefulWidget {
  final String? title;
  final String? subTitle;

  const ConfirmBookingDialog({super.key, this.title, this.subTitle});

  @override
  State<ConfirmBookingDialog> createState() => _ConfirmBookingDialog();
}

class _ConfirmBookingDialog extends State<ConfirmBookingDialog> {
  bool isSelected = false;

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
    return SizedBox(
      width: context.width(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(ic_confirm_check,
              height: 100, width: 100, color: primaryColor),
          16.height,
          Text(widget.title ?? locale.confirmBooking,
              style: boldTextStyle(size: 20), textAlign: TextAlign.center),
          16.height,
          Text(widget.subTitle ?? locale.doWantToBookAppointment,
                  style: primaryTextStyle(), textAlign: TextAlign.center)
              .center(),
          16.height,
          CheckboxListTile(
            value: isSelected,
            onChanged: (val) async {
              await setValue(SharedPreferenceConst.IS_SELECTED, isSelected);
              isSelected = !isSelected;
              setState(() {});
            },
            title: Text(locale.termsConditionsMessage,
                style: secondaryTextStyle()),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          24.height,
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
                onTap: () {
                  if (isSelected) {
                    finish(context, true);
                  } else {
                    toast(locale.pleaseAcceptTermsAndConditions);
                  }
                },
                child: Text(locale.confirm, style: boldTextStyle(color: white)),
              ).expand(),
            ],
          ),
        ],
      ),
    );
  }
}
