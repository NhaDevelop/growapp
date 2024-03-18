import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/cart/model/country_list_response.dart';
import 'package:grow_tokyo_app/screens/dashboard/dashboard_repository.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

class AppCountryScreen extends StatefulWidget {
  const AppCountryScreen({super.key});

  @override
  State<AppCountryScreen> createState() => _AppCountryScreenState();
}

class _AppCountryScreenState extends State<AppCountryScreen> {
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

  int? getCountryIdByName(String name) {
    final index = countries.indexWhere((element) => element.name == name);
    if (index < 0) return null;
    return countries[index].id;
  }

  void onTap(int countryId) {
    appStore.setCountryId(countryId);
    setState(() {});
    finish(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final appCountryList = countryList();
    return Scaffold(
      appBar: commonAppBarWidget(context, title: locale.country),
      body: AnimatedListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: appCountryList.length,
        itemBuilder: (_, index) {
          final country = appCountryList[index];
          final countryId = getCountryIdByName(country.name);
          return SettingItemWidget(
            leading: Image.asset(
              country.icon,
              height: 20,
              width: 20,
              fit: BoxFit.cover,
            ),
            title: country.name.validate(),
            splashColor: Colors.transparent,
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            onTap: countryId == null ? null : () => onTap(countryId),
            trailing: Observer(builder: (context) {
              return appStore.countryId == countryId
                  ? Icon(Icons.check, color: context.iconColor)
                  : const SizedBox.shrink();
            }),
          ).paddingTop(16);
        },
      ),
    );
  }
}
