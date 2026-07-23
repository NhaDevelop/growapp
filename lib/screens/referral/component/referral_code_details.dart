import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/referral/component/how_it_work_modal.dart';
import 'package:grow_tokyo_app/screens/referral/model/referral_data.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferralCodeDetails extends StatefulWidget {
  final ReferralData? data;
  const ReferralCodeDetails({super.key, this.data});

  @override
  State<ReferralCodeDetails> createState() => _ReferralCodeDetailsState();
}

class _ReferralCodeDetailsState extends State<ReferralCodeDetails> {
  final GlobalKey boundaryKey = GlobalKey();

  // Warm near-black to match the ink tone in the reference card
  static const Color inkColor = Color(0xFF1A140E);

  Future<void> onCopyCode(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    toast(locale.copiedToClipboard);
  }

  Future<void> onShare(BuildContext context) async {
    if (widget.data == null || widget.data!.code.isEmpty) return;

    // Show loading
    appStore.setLoading(true);

    try {
      final boundary = boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) throw Exception("Could not find boundary");

      // Capture the image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/referral_card.png').create();
      await file.writeAsBytes(pngBytes);

      appStore.setLoading(false);

      final text = locale.shareReferralCode(
        widget.data!.code,
        widget.data!.rewardPercentage,
      );

      if (!mounted) return;

      // Get the position of the share button for iOS
      final box = context.findRenderObject() as RenderBox?;
      final sharePositionOrigin =
          box == null ? null : box.localToGlobal(Offset.zero) & box.size;

      await Share.shareXFiles(
        [XFile(file.path)],
        text: text,
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (e) {
      appStore.setLoading(false);
      log(e.toString());
      toast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RepaintBoundary(
          key: boundaryKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The referral card image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final cardWidth = constraints.maxWidth;
                        final cardHeight = cardWidth * 1.25;
                        return SizedBox(
                          width: cardWidth,
                          height: cardHeight,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  referral_card_no_qr,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: cardHeight * 0.22,
                                left: 0,
                                right: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: cardWidth * 0.065,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        color: inkColor,
                                        letterSpacing: 3.0,
                                        fontFamily: 'PlayfairDisplay',
                                      ),
                                      children: [
                                        const TextSpan(text: "Code : "),
                                        TextSpan(
                                            text: widget.data?.code ?? 'N/A'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Text banner baked into the image so Messenger shows it
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF12213A),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🎁 Get ${widget.data?.rewardPercentage ?? 0}% off your first booking!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Use my code: ${widget.data?.code ?? ''} on grow Tokyo app',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
              enabled: widget.data != null && widget.data!.code.isNotEmpty,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.white,
              onTap: () => onCopyCode(widget.data!.code),
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
              enabled: widget.data != null && widget.data!.code.isNotEmpty,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.white,
              onTap: () => onShare(context),
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
        ).paddingSymmetric(horizontal: 16),
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
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
