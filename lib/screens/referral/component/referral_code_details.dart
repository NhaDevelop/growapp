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
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ReferralCodeDetails extends StatefulWidget {
  final ReferralData? data;
  const ReferralCodeDetails({super.key, this.data});

  @override
  State<ReferralCodeDetails> createState() => _ReferralCodeDetailsState();
}

class _ReferralCodeDetailsState extends State<ReferralCodeDetails> {
  final GlobalKey boundaryKey = GlobalKey();

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
            height: 240,
            width: context.width(),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(referral_card_bg, fit: BoxFit.cover)
                      .cornerRadiusWithClipRRect(16),
                ),
                // Decorative Gradient Overlay for better text readability
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Row: Logo and Crown Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(app_logo, height: 35),
                          Image.asset(ic_crown,
                              height: 20, color: Colors.white.withOpacity(0.8)),
                        ],
                      ),
                      // Middle Row: Referral Information & QR Code
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale.yourReferralCode.toUpperCase(),
                                style: secondaryTextStyle(
                                    size: 10,
                                    color: Colors.white70,
                                    letterSpacing: 2),
                              ),
                              2.height,
                              Text(
                                widget.data == null || widget.data!.code.isEmpty
                                    ? 'N/A'
                                    : widget.data!.code,
                                style: boldTextStyle(size: 26, color: white),
                              ),
                              2.height,
                              Text(
                                "SHARE & GET POINTS",
                                style: boldTextStyle(
                                    size: 10,
                                    color: const Color(0xFFFFD700)), // Gold
                              ),
                            ],
                          ).expand(),
                          12.width,
                          // QR Code Container
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    spreadRadius: 1),
                              ],
                            ),
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: SfBarcodeGenerator(
                                value: widget.data?.code ?? 'N/A',
                                symbology: QRCode(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Bottom Section: Salon Invitation Text
                      Column(
                        children: [
                          Text(
                            "INVITE FRIENDS. GET REWARDED.",
                            style: boldTextStyle(
                                size: 12, color: white, letterSpacing: 0.5),
                          ),
                          Text(
                            "Beautiful hair for everyone. Points for you.",
                            style: secondaryTextStyle(
                                size: 8, color: Colors.white70),
                          ),
                        ],
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
