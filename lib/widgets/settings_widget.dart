import 'package:flutter/material.dart';
import 'package:unit/constants/colors.dart';
import 'package:unit/constants/enums.dart';
import 'package:unit/data/settings.dart';
import 'package:unit/unit_converter_app.dart';
import 'package:unit/utils/app_localization.dart';
import 'package:unit/utils/device_utils.dart';
import 'package:unit/utils/mail_helper.dart';
import 'package:unit/utils/shared_prefs_helper.dart';
import 'package:launch_review/launch_review.dart';

/// Settings widget
class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

/// Settings widget state
class _SettingsWidgetState extends State<SettingsWidget> {
  /// Const of text default height. Converts with scale coef.
  static const double textValueScaleFactor = 16.0;

  /// Const of text default height. Converts with scale coef.
  static const double textDescriptionScaleFactor = 12.0;

  /// List of dropdown items for locale enum
  List<DropdownMenuItem<String>> _dropDownLocaleItems;

  /// List of dropdown items for theme enum
  List<DropdownMenuItem<String>> _dropDownThemeItems;

  /// List of dropdown items for accuracy
  List<DropdownMenuItem<String>> _dropDownAccuracyItems;

  /// List of dropdown items for decimal separator items
  List<DropdownMenuItem<String>> _dropDownDecimalSeparatorItems;

  /// List of dropdown items for group separator items
  List<DropdownMenuItem<String>> _dropDownGroupSeparatorItems;

  /// List of dropdown items for measure format items
  List<DropdownMenuItem<String>> _dropDownFormatItems;

  /// Current locale to catch localization changed event
  Locale _currentLocale;

  /// Flag is settings changed to save it to json
  bool _settingsChanged = false;

  /// State initialization
  @override
  void initState() {
    super.initState();
  }

  /// Widget building
  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle patternStyle = theme.textTheme.bodyText2.copyWith(
        fontSize: DeviceUtils.getScaledText(context, textValueScaleFactor),
        color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor);
    final TextStyle valueStyle = theme.textTheme.bodyText1.copyWith(fontSize: DeviceUtils.getScaledText(context, textValueScaleFactor));
    final TextStyle descriptionStyle = theme.textTheme.bodyText1.copyWith(fontSize: DeviceUtils.getScaledText(context, textDescriptionScaleFactor));

    if (_currentLocale != locale.locale || _dropDownThemeItems == null) {
      _currentLocale = locale.locale;

      _dropDownThemeItems = _getDropDownThemeItems();
      _dropDownLocaleItems = _getDropDownLocaleItems();
      _dropDownDecimalSeparatorItems = _getDropDownDecimalSeparatorItems();
      _dropDownGroupSeparatorItems = _getDropDownGroupSeparatorItems();
      _dropDownAccuracyItems = _getDropDownAccuracyItems();
      _dropDownFormatItems = _getDropDownFormatItems();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(locale.translate('SettingsTitle'), style: theme.textTheme.caption),
          brightness: UnitConverterApp.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (BuildContext context) => GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              if (details.delta.dx > 10) {
                _onExit();
              }
            },
            child: WillPopScope(
                onWillPop: () async {
                  _onExit();
                  return false;
                },
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 4, child: ListTile(title: Text(AppLocalizations.of(context).translate('SettingsLanguage'), style: valueStyle))),
                        Expanded(
                            flex: 7,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _localToString(locale.locale.languageCode),
                                  items: _dropDownLocaleItems,
                                  style: valueStyle,
                                  onChanged: _changedLocale,
                                  icon: Icon(
                                    // Add this
                                    Icons.arrow_drop_down, // Add this
                                    color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor, // Add this
                                  ),
                                ))),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 4, child: ListTile(title: Text(AppLocalizations.of(context).translate('SettingsTheme'), style: valueStyle))),
                        Expanded(
                            flex: 7,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _themeToString(UnitConverterApp.settings.themeStyle),
                                  items: _dropDownThemeItems,
                                  style: valueStyle,
                                  onChanged: _changedTheme,
                                  icon: Icon(
                                    // Add this
                                    Icons.arrow_drop_down, // Add this
                                    color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor, // Add this
                                  ),
                                ))),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 4, child: ListTile(title: Text(AppLocalizations.of(context).translate('SettingsUnitFormat'), style: valueStyle))),
                        Expanded(
                            flex: 7,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _unitFormatToString(UnitConverterApp.settings.unitFormat),
                                  items: _dropDownFormatItems,
                                  style: valueStyle,
                                  onChanged: _changedFormat,
                                  icon: Icon(
                                    // Add this
                                    Icons.arrow_drop_down, // Add this
                                    color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor, // Add this
                                  ),
                                ))),
                      ],
                    ),
                    const Divider(
                      height: 2,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 4, child: ListTile(title: Text(AppLocalizations.of(context).translate('SettingsAccuracy'), style: valueStyle))),
                        Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: UnitConverterApp.settings.accuracy.toString(),
                                  items: _dropDownAccuracyItems,
                                  style: valueStyle,
                                  onChanged: _changedAccuracy,
                                  icon: Icon(
                                    // Add this
                                    Icons.arrow_drop_down, // Add this
                                    color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor, // Add this
                                  ),
                                ))),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 4,
                            child: ListTile(title: Text(AppLocalizations.of(context).translate('SettingsDecimalSeparator'), style: valueStyle))),
                        Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _decimalSeparatorToString(UnitConverterApp.settings.decimalSeparator),
                                  items: _dropDownDecimalSeparatorItems,
                                  style: valueStyle,
                                  onChanged: _changedDecimalSeparator,
                                  icon: Icon(
                                    // Add this
                                    Icons.arrow_drop_down, // Add this
                                    color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor, // Add this
                                  ),
                                ))),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 4,
                            child: ListTile(title: Text(AppLocalizations.of(context).translate('SettingsGroupSeparator'), style: valueStyle))),
                        Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _groupSeparatorToString(UnitConverterApp.settings.groupSeparator),
                                  items: _dropDownGroupSeparatorItems,
                                  style: valueStyle,
                                  onChanged: _changedGroupSeparator,
                                  icon: Icon(
                                    // Add this
                                    Icons.arrow_drop_down, // Add this
                                    color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor, // Add this
                                  ),
                                ))),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 4, child: ListTile(title: Text(AppLocalizations.of(context).translate('SettingsPattern'), style: valueStyle))),
                        Expanded(
                            flex: 7,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: Text(
                                  UnitConverterApp.settings.formatter.format(1234567.12345),
                                  style: patternStyle,
                                  textAlign: TextAlign.right,
                                ))),
                      ],
                    ),
                    const Divider(
                      height: 2,
                    ),
                    ListTile(
                      title: Text(locale.translate('SettingsSendMessage'), style: valueStyle),
                      leading: Icon(Icons.mail_outline, color: theme.primaryColor),
                      dense: true,
                      onTap: () {
                        DeviceUtils.showSnackbar(context, locale.translate('ThankYou'), MailToHelper.sendMessage, true);
                      },
                    ),
                    ListTile(
                      title: Text(locale.translate('SettingsRate'), style: valueStyle),
                      subtitle: Text(locale.translate('SettingsRateDesc'), style: descriptionStyle),
                      leading: Icon(Icons.star, color: theme.primaryColor),
                      dense: true,
                      onTap: () {
                        DeviceUtils.showSnackbar(context, locale.translate('ThankYou'), LaunchReview.launch, false);
                      },
                    ),
                    const Divider(
                      height: 15,
                    ),
                    ListTile(
                      subtitle: Text(locale.translate('SettingsThanksDesc'), style: descriptionStyle),
                      leading: Icon(Icons.sentiment_satisfied, color: theme.primaryColor),
                      dense: true,
                    ),
                  ],
                )),
          ),
        ));
  }

  /// Event on exit widget
  Future<void> _onExit() async {
    if (_settingsChanged) {
      SharedPrefsHelper.savePrefs(Settings.SettingsJsonTitle, UnitConverterApp.settings.toJson(context));
    }

    Navigator.pop(context, _settingsChanged);
  }

  /// Event on user changed locale
  void _changedTheme(String themeStr) {
    setState(() {
      UnitConverterApp.settings.updateTheme(context, UnitConverterApp.settings.themeStyleFromString(themeStr));
      _settingsChanged = true;
    });
  }

  /// Event on user changed locale
  void _changedLocale(String localeStr) {
    final String localeName = localeStr == 'English' ? 'en' : 'ru';
    UnitConverterApp.settings.updateLocale(context, Locale(localeName, ''));
    _settingsChanged = true;
  }

  /// Event on user changed decimal separator
  void _changedDecimalSeparator(String decimalSeparatorStr) {
    setState(() {
      _settingsChanged = true;
      UnitConverterApp.settings.decimalSeparator = UnitConverterApp.settings.decimalSeparatorFromString(decimalSeparatorStr);
      UnitConverterApp.settings.updateNumberFormat();
    });
  }

  /// Event on user changed group separator
  void _changedGroupSeparator(String groupSeparatorStr) {
    setState(() {
      _settingsChanged = true;
      UnitConverterApp.settings.groupSeparator = UnitConverterApp.settings.groupSeparatorFromString(groupSeparatorStr);
      UnitConverterApp.settings.updateNumberFormat();
    });
  }

  /// Event on user changed accuracy
  void _changedAccuracy(String accuracyStr) {
    setState(() {
      _settingsChanged = true;
      UnitConverterApp.settings.accuracy = int.tryParse(accuracyStr);
      UnitConverterApp.settings.updateNumberFormat();
    });
  }

  /// Event on user changed format
  void _changedFormat(String formatStr) {
    setState(() {
      _settingsChanged = true;
      UnitConverterApp.settings.unitFormat = UnitConverterApp.settings.unitFormatFromString(formatStr);
    });
  }

  /// Get drop down control item
  DropdownMenuItem<String> _getDropDownItem(String title) {
    return DropdownMenuItem<String>(value: title, child: Align(alignment: Alignment.center, child: Text(title)));
  }

  /// Get theme dropdown items
  List<DropdownMenuItem<String>> _getDropDownThemeItems() {
    final List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (ThemeStyleEnum enumValue in ThemeStyleEnum.values) {
      final String title = _themeToString(enumValue);
      items.add(DropdownMenuItem<String>(value: title, child: Text(title)));
    }

    return items;
  }

  /// Get locale dropdown items
  List<DropdownMenuItem<String>> _getDropDownLocaleItems() {
    final List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (String localeValue in AppLocalizations.supportedLanguages) {
      final String title = _localToString(localeValue);
      items.add(DropdownMenuItem<String>(value: title, child: Text(title)));
    }
    return items;
  }

  /// Get group separator dropdown items
  List<DropdownMenuItem<String>> _getDropDownGroupSeparatorItems() {
    final List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (GroupSeparatorEnum enumValue in GroupSeparatorEnum.values) {
      final String title = _groupSeparatorToString(enumValue);
      items.add(_getDropDownItem(title));
    }
    return items;
  }

  /// Get accuracy dropdown items
  List<DropdownMenuItem<String>> _getDropDownAccuracyItems() {
    final List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (int i = 0; i <= 5; i++) {
      final String title = i.toString();
      items.add(_getDropDownItem(title));
    }

    return items;
  }

  /// Get measure format dropdown items
  List<DropdownMenuItem<String>> _getDropDownFormatItems() {
    final List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (UnitsFormatEnum enumValue in UnitsFormatEnum.values) {
      final String title = _unitFormatToString(enumValue);
      items.add(DropdownMenuItem<String>(value: title, child: Text(title)));
    }
    return items;
  }

  /// Get decimal separator dropdown items
  List<DropdownMenuItem<String>> _getDropDownDecimalSeparatorItems() {
    final List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (DecimalSeparatorEnum enumValue in DecimalSeparatorEnum.values) {
      final String title = _decimalSeparatorToString(enumValue);
      items.add(_getDropDownItem(title));
    }
    return items;
  }

  /// Convert enum value to enum caption
  String _decimalSeparatorToString(DecimalSeparatorEnum enumValue) {
    switch (enumValue) {
      case DecimalSeparatorEnum.Dot:
        return '.';
      default:
        return ',';
    }
  }

  /// Convert enum value to enum caption
  String _groupSeparatorToString(GroupSeparatorEnum enumValue) {
    switch (enumValue) {
      case GroupSeparatorEnum.Space:
        return AppLocalizations.of(context).translate('SettingsGroupSpace');
      case GroupSeparatorEnum.None:
        return AppLocalizations.of(context).translate('SettingsGroupNone');
      case GroupSeparatorEnum.Dot:
        return '.';
      default:
        return ',';
    }
  }

  /// Convert enum value to enum caption
  String _unitFormatToString(UnitsFormatEnum enumValue) {
    switch (enumValue) {
      case UnitsFormatEnum.Full:
        return AppLocalizations.of(context).translate('SettingsUnitFull');
      default:
        return AppLocalizations.of(context).translate('SettingsUnitSymbol');
    }
  }

  /// Convert enum value to enum caption
  String _themeToString(ThemeStyleEnum enumValue) {
    switch (enumValue) {
      case ThemeStyleEnum.Light:
        return AppLocalizations.of(context).translate('SettingsThemeLight');
      case ThemeStyleEnum.Dark:
        return AppLocalizations.of(context).translate('SettingsThemeDark');
      default:
        return AppLocalizations.of(context).translate('SettingsThemeSystem');
    }
  }

  /// Convert enum value to enum caption
  String _localToString(String languageCode) {
    if (languageCode == 'en') {
      return 'English';
    }

    return 'Русский';
  }
}
