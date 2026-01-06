import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/cart/model/country_list_response.dart';
import 'package:grow_tokyo_app/screens/dashboard/dashboard_repository.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectCountryDialog extends StatefulWidget {
  const SelectCountryDialog({super.key});

  @override
  State<SelectCountryDialog> createState() => _SelectCountryDialogState();
}

class _SelectCountryDialogState extends State<SelectCountryDialog> {
  AppCountryModel? _selected;
  final List<CountryData> countries = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      final list = await getCountries();
      countries.addAll(list);
      setState(() {});
    } catch (e) {
      toast(e.toString());
    }
  }

  void _onSelect() {
    if (_selected == null) return;
    final index =
        countries.indexWhere((element) => element.name == _selected!.name);
    if (index < 0) return;

    log('💰 Saving country selection:');
    log('   Country: ${_selected!.name}');
    log('   Currency Code: ${_selected!.currencyCode}');
    log('   Currency Symbol: ${_selected!.currencySymbol}');

    appStore.setCountryId(countries[index].id.validate());
    appStore.setCountryCode(_selected!.countryCode.validate());
    appStore.setCurrencyCode(_selected!.currencyCode.validate());
    appStore.setCurrencySymbol(_selected!.currencySymbol.validate());

    log('✅ Country settings saved to persistent storage');
    finish(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final appCountryList = countryList();
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      title: AppBar(
        title: Text(locale.selectCountry),
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
            children: appCountryList
                .map((e) => _Item(
                    key: ValueKey(e.name),
                    width: context.width() * 0.35,
                    icon: e.icon,
                    title: e.name,
                    selected: e.name == _selected?.name,
                    onTap: () => setState(() => _selected = e)))
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
