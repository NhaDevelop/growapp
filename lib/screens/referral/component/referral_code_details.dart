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
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  // Clean silk background (no fake QR or text)
                  Positioned.fill(
                    child: Image.asset(
                      referral_silk_clean,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Full card content built entirely in Flutter
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --- Header: Hair & Make label + Grow Tokyo Logo ---
                        Text(
                          "Hair & Make",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: 1.5,
                            fontFamily: 'serif',
                          ),
                        ),
                        6.height,
                        Image.asset(
                          grow_tokyo_logo,
                          height: 60,
                        ),
                        28.height,

                        // --- 15% OFF double border box ---
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black87, width: 1.5),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black87, width: 0.8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Center(
                              child: Text(
                                "15 % OFF",
                                style: TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        20.height,

                        // --- Description Text removed per request ---

                        // --- QR Code with clean white background ---
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black26, width: 1),
                          ),
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: SfBarcodeGenerator(
                              value: widget.data?.code ?? 'N/A',
                              symbology: QRCode(),
                            ),
                          ),
                        ),
                        16.height,

                        // --- Referral Code Text ---
                        Text(
                          "Referral Code: ${widget.data?.code ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            letterSpacing: 0.5,
                          ),
                        ),
                        8.height,
                      ],
                    ),
                  ),
                ],
              ),
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
