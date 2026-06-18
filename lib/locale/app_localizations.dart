import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/locale/language_km.dart';
import 'package:grow_tokyo_app/locale/language_vi.dart';
import 'package:nb_utils/nb_utils.dart';

import 'language_en.dart';
import 'languages.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'vi':
        return LanguageVi();
      case 'km':
        return LanguageKm();
      default:
        return LanguageEn();
    }
  }
  @override
  bool isSupported(Locale locale) =>
      LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}
