import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectLanguageDialog extends StatefulWidget {
  const SelectLanguageDialog({super.key});

  @override
  State<SelectLanguageDialog> createState() => _SelectLanguageDialogState();
}

class _SelectLanguageDialogState extends State<SelectLanguageDialog> {
  late String? _selected = appStore.selectedLanguageCode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      title: AppBar(
        title: Text(locale.appLanguage),
        automaticallyImplyLeading: false,
      ).cornerRadiusWithClipRRect(20),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 16,
            runSpacing: 16,
            children: languageList()
                .map((e) => _Item(
                    key: ValueKey(e.name),
                    width: context.width() * 0.25,
                    icon: e.flag.validate(),
                    title: e.name.validate(),
                    selected: e.languageCode == _selected,
                    onTap: () => setState(() => _selected = e.languageCode)))
                .toList(),
          ),
          24.height,
          AppButton(
            text: locale.select,
            width: context.width(),
            color: context.primaryColor,
            textColor: Colors.white,
            disabledColor: const Color(0xFFE0E0E0),
            enabled: _selected != null,
            onTap: () {
              appStore.setLanguage(_selected!);
              finish(context, true);
              setState(() {});
            },
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
  final double? width;
  const _Item(
      {super.key,
      required this.icon,
      required this.title,
      required this.selected,
      required this.onTap,
      this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: width,
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: const Color(0xFFF2F2F2),
          borderRadius: radius(16),
          border: Border.all(
            color: selected ? context.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Image.asset(icon, width: 48, height: 48),
            8.height,
            Text(title, style: boldTextStyle(size: 14)),
          ],
        ),
      ),
    );
  }
}
