import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/referral/component/how_it_work_modal.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';

class ReferralCodeDetails extends StatelessWidget {
  final String code;
  const ReferralCodeDetails({super.key, required this.code});

  Future<void> onCopyCode(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    toast(locale.copiedToClipboard);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(16),
        backgroundColor: context.cardColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            locale.yourReferralCode.toUpperCase(),
            style: secondaryTextStyle(size: 12),
          ),
          8.height,
          Text(
            code.isEmpty ? 'N/A' : code,
            style: boldTextStyle(size: 24),
          ),
          24.height,
          Row(
            children: [
              AppButton(
                elevation: 0,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(),
                ),
                enabled: code.isNotEmpty,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.white,
                onTap: () => onCopyCode(code),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ic_copy, height: 16, width: 16),
                    8.width,
                    Text(locale.copyCode, style: boldTextStyle()),
                  ],
                ),
              ).expand(),
              16.width,
              AppButton(
                elevation: 0,
                color: const Color(0xFF12213A),
                textColor: Colors.white,
                enabled: code.isNotEmpty,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.white,
                onTap: () => Share.share(code),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ic_share,
                        height: 16, width: 16, color: Colors.white),
                    8.width,
                    Text(locale.share, style: boldTextStyle(color: white)),
                  ],
                ),
              ).expand(),
            ],
          ),
          24.height,
          Row(
            children: [
              Image.asset(referral_reward, height: 32, width: 32),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.referralRewardMessage,
                    style: primaryTextStyle(size: 16),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => const HowItWorksModal(),
                    ),
                    child: Text(
                      locale.howItWorks,
                      style: primaryTextStyle(
                        size: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ).paddingOnly(bottom: 8, right: 8),
                  ),
                ],
              ).expand(),
            ],
          ),
        ],
      ).paddingAll(16),
    );
  }
}
