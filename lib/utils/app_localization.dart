import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Class for working with localization
class AppLocalizations {
  // constructor
  AppLocalizations(this.locale);

  // supported languages
  static const List<String> supportedLanguages = <String>['en', 'ru'];

  // localization variables
  final Locale locale;

  Map<String, String> localizedStrings;

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // This is a helper method that will load local specific strings from file
  // present in lang folder
  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    final String jsonString = await rootBundle.loadString('Resources/Strings/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((String key, dynamic value) {
      return MapEntry<String, String>(key, value.toString());
    });

    return true;
  }

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return localizedStrings[key];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return AppLocalizations.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final AppLocalizations localization = AppLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
