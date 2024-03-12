import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class InquiryDialog extends StatefulWidget {
  const InquiryDialog({super.key});

  @override
  State<InquiryDialog> createState() => _InquiryDialogState();
}

class _InquiryDialogState extends State<InquiryDialog> {
  InquiryType? _selected;

  void _onSelect() {
    if (_selected == null) return;

    launchUrl(Uri.parse(_selected!.url));
    finish(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      title: AppBar(
        title: Text(locale.inquiry, style: boldTextStyle(size: 20)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => finish(context),
          ),
        ],
      ).cornerRadiusWithClipRRect(12),
      titlePadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(locale.inquiryMessage, textAlign: TextAlign.center),
          24.height,
          Row(
            children: [
              _Item(
                key: const ValueKey(InquiryType.telegram),
                icon: ic_telegram,
                title: locale.telegram,
                selected: _selected == InquiryType.telegram,
                onTap: () => setState(() => _selected = InquiryType.telegram),
              ).expand(),
              16.width,
              _Item(
                key: const ValueKey(InquiryType.messenger),
                icon: ic_messenger,
                title: locale.messenger,
                selected: _selected == InquiryType.messenger,
                onTap: () => setState(() => _selected = InquiryType.messenger),
              ).expand(),
            ],
          ),
          24.height,
          AppButton(
            text: locale.select,
            width: context.width(),
            color: context.primaryColor,
            textColor: Colors.white,
            disabledColor: const Color(0xFFE0E0E0),
            disabledTextColor: Colors.grey,
            enabled: _selected != null,
            onTap: _onSelect,
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;
  const _Item(
      {super.key,
      required this.icon,
      required this.title,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: const Color(0xFFF2F2F2),
          borderRadius: radius(16),
          border: Border.all(
            color: selected ? context.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(icon, width: 60, height: 60),
            8.height,
            Text(title, style: boldTextStyle(size: 14)),
          ],
        ),
      ),
    );
  }
}

enum InquiryType { telegram, messenger }

extension InquiryTypeExtension on InquiryType {
  String get url {
    switch (this) {
      case InquiryType.telegram:
        return '';
      default:
        return '';
    }
  }
}
