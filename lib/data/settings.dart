import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unit/constants/enums.dart';
import 'package:unit/data/measure.dart';
import 'package:unit/unit_converter_app.dart';
import 'package:unit/utils/shared_prefs_helper.dart';

import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';
import 'package:unit/utils/type_helpers.dart';

/// Settings of application
class Settings {
  /// JSON key title
  static const String SettingsJsonTitle = 'Settings';

  /// Current locale
  Locale locale;

  ThemeStyleEnum themeStyle;

  /// Decimal separator
  DecimalSeparatorEnum decimalSeparator = DecimalSeparatorEnum.Comma;

  /// Group separator
  GroupSeparatorEnum groupSeparator = GroupSeparatorEnum.Space;

  UnitsFormatEnum unitFormat = UnitsFormatEnum.Full;

  /// Accuracy
  int accuracy = 2;

  /// Current number formatter based on user decimal/group separators and accuracy
  NumberFormat formatter;

  /// Save class to JSON
  Map<String, dynamic> toJson(BuildContext context) => <String, dynamic>{
        'language': locale.languageCode,
        'decimalSeparator': decimalSeparator.toString(),
        'groupSeparator': groupSeparator.toString(),
        'Accuracy': accuracy.toString(),
        'themeStyle': TypeHelpers.getEnumCaption(themeStyle),
        'unitFormat': unitFormat.toString()
      };

  /// Load class from JSON
  void _fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }

    final String localeStr = json['language'];
    if (localeStr != null && localeStr != '') {
      locale = Locale(localeStr, '');
    } else {
      locale = Locale(window.locale.languageCode, '');
    }

    final String decimalSeparatorStr = json['decimalSeparator'];
    if (decimalSeparatorStr == null) {
      decimalSeparator = locale.languageCode == 'en' ? DecimalSeparatorEnum.Dot : DecimalSeparatorEnum.Comma;
    } else {
      decimalSeparator = decimalSeparatorFromString(decimalSeparatorStr);
    }

    final String groupSeparatorStr = json['groupSeparator'];
    groupSeparator = groupSeparatorFromString(groupSeparatorStr) ?? GroupSeparatorEnum.Space;

    accuracy = int.tryParse(json['Accuracy']) ?? 2;

    final String themeStyleStr = json['themeStyle'];
    themeStyle = themeStyleFromString(themeStyleStr) ?? ThemeStyleEnum.System;

    final String unitFormatStr = json['unitFormat'];
    unitFormat = unitFormatFromString(unitFormatStr) ?? UnitsFormatEnum.Full;
  }

  /// Update locale in app
  Future<void> updateLocale(BuildContext context, Locale newLocale) async {
    locale = newLocale;

    final UnitConverterAppState state = context.findAncestorStateOfType<UnitConverterAppState>();
    state.changeLocale();
  }

  /// Update locale in app
  Future<void> updateTheme(BuildContext context, ThemeStyleEnum newTheme) async {
    themeStyle = newTheme;

    final UnitConverterAppState state = context.findAncestorStateOfType<UnitConverterAppState>();
    state.changeTheme();
  }

  /// Convert string decimal separator to enum
  DecimalSeparatorEnum decimalSeparatorFromString(String caption) {
    if (caption == DecimalSeparatorEnum.Dot.toString() || caption == '.') {
      return DecimalSeparatorEnum.Dot;
    }

    return DecimalSeparatorEnum.Comma;
  }

  /// Convert string group separator to enum
  GroupSeparatorEnum groupSeparatorFromString(String caption) {
    if (caption == GroupSeparatorEnum.Space.toString() || caption == ' ' || caption == 'Пробел' || caption == 'Space' || caption == null) {
      return GroupSeparatorEnum.Space;
    }

    if (caption == GroupSeparatorEnum.None.toString() || caption == 'None' || caption == 'Нет') {
      return GroupSeparatorEnum.None;
    }

    if (caption == GroupSeparatorEnum.Comma.toString() || caption == ',') {
      return GroupSeparatorEnum.Comma;
    }

    return GroupSeparatorEnum.Dot;
  }

  /// Convert string unitFormat to enum
  UnitsFormatEnum unitFormatFromString(String caption) {
    if (caption == UnitsFormatEnum.Full.toString() || caption == null || caption == 'Текстовый' || caption == 'Text') {
      return UnitsFormatEnum.Full;
    }

    return UnitsFormatEnum.Symbol;
  }

  /// Convert string group separator to enum
  ThemeStyleEnum themeStyleFromString(String caption) {
    if (caption == 'System' || caption == 'Системная' || caption == null) {
      return ThemeStyleEnum.System;
    }

    if (caption == 'Light' || caption == 'Светлая') {
      return ThemeStyleEnum.Light;
    }

    return ThemeStyleEnum.Dark;
  }

  /// Load main settings
  Future<void> loadSettings() async {
    // Загрузка непосредственно самих настроек программы
    final dynamic jsonValues = await SharedPrefsHelper.loadPrefs(Settings.SettingsJsonTitle);
    _fromJson(jsonValues);
    updateNumberFormat();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    // Загрузка избранных и последних выбранных значений единиц измерения
    for (MeasureInfo value in measuresInfo.values) {
      final String jsonKey = TypeHelpers.getEnumCaption(value.measure);
      final dynamic jsonValues = await SharedPrefsHelper.loadPrefs(jsonKey);
      if (jsonValues == null || jsonValues == '') {
        continue;
      }

      value.fromJson(jsonValues);
    }
  }

  /// Update program number format
  void updateNumberFormat() {
    final String decimalSep = decimalSeparator == DecimalSeparatorEnum.Dot ? '.' : ',';
    String groupSep = '';
    switch (groupSeparator) {
      case GroupSeparatorEnum.Space:
        groupSep = ' ';
        break;
      case GroupSeparatorEnum.Comma:
        groupSep = ',';
        break;
      case GroupSeparatorEnum.Dot:
        groupSep = '.';
        break;
      case GroupSeparatorEnum.None:
        groupSep = '';
        break;
    }

    String accuracyStr = accuracy > 0 ? '.' : '';
    for (int i = 1; i <= accuracy; ++i) {
      accuracyStr += '#';
    }
    numberFormatSymbols['zz'] = NumberSymbols(
      NAME: 'zz',
      DECIMAL_SEP: decimalSep,
      GROUP_SEP: groupSep,
      PERCENT: '%',
      ZERO_DIGIT: '0',
      PLUS_SIGN: '+',
      MINUS_SIGN: '-',
      EXP_SYMBOL: 'e',
      PERMILL: '\u2030',
      INFINITY: '\u221E',
      NAN: 'NaN',
      DECIMAL_PATTERN: '0,##0' + accuracyStr,
      SCIENTIFIC_PATTERN: '#E0',
      PERCENT_PATTERN: '#,##0%',
      CURRENCY_PATTERN: '\u00A4#,##0.00',
      DEF_CURRENCY_CODE: 'AUD',
    );

    formatter = NumberFormat('###,###' + accuracyStr, 'zz');
  }
}
