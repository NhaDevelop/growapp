import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/modal_header.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class HowItWorksModal extends StatelessWidget {
  const HowItWorksModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ModalHeader(title: locale.howItWorks),
        const Divider(height: 0),
        16.height,
        SettingItemWidget(
          title: locale.referralStep1,
          leading: Image.asset(ic_send_2, width: 24, height: 24),
        ),
        SettingItemWidget(
          title: locale.referralStep2,
          leading: Image.asset(ic_percentage_square, width: 24, height: 24),
        ),
        SettingItemWidget(
          title: locale.referralStep3,
          leading: Image.asset(ic_crown, width: 24, height: 24),
        ),
        24.height,
        DottedBorderWidget(
          color: const Color(0xFFF2994A),
          radius: 4,
          child: Container(
            color: const Color(0xFFF2C94C).withOpacity(.2),
            child: Text(
              locale.referralStepNote,
              style: primaryTextStyle(size: 14, weight: FontWeight.w500),
            ).paddingAll(16),
          ),
        ).paddingSymmetric(horizontal: 16),
        68.height,
      ],
    ).paddingSymmetric(horizontal: 8);
  }
}
