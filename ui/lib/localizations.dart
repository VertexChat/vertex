/// This file will contain all language locations
/// Adapted from: https://www.youtube.com/watch?v=Fm3DBGlqO-o
/// Author: Morgan Reilly -- G00303598

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  /// Need to create properties for each item to be localized
  /// We'll just start with the title
  String get title {
    return Intl.message('Welcome Home', name: 'title');
  }

  String get locale {
    return Intl.message('en', name: 'locale');
  }
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
