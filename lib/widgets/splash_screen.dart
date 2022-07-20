import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unit/constants/colors.dart';
import 'package:unit/routes.dart';
import 'package:unit/unit_converter_app.dart';
import 'package:unit/utils/device_utils.dart';

/// Splash screen widget
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

/// Splash screen state
class _SplashScreenState extends State<SplashScreen> {
  /// Widget initialization
  @override
  void initState() {
    super.initState();

    const Duration _duration = Duration(milliseconds: 2000);
    Timer(_duration, _navigate);
  }

  /// Widget building
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = DeviceUtils.isDarkMode(context);
    final Color color = isDarkMode ? AppColors.primaryDarkColor : AppColors.primaryLightColor;
    const double studioTextScaleFactor = 25;

    final TextStyle studioStyle = theme.textTheme.bodyText1
        .copyWith(fontSize: DeviceUtils.getScaledText(context, studioTextScaleFactor), color: isDarkMode ? Colors.white60 : Colors.black54);

    final Image image = Image.asset(
      'Resources/Images/splash.png',
      alignment: Alignment.topCenter,
    );

    final Image imageLogo =
        Image.asset('Resources/Images/logo.png', alignment: Alignment.bottomRight, color: isDarkMode ? Colors.white60 : Colors.black54);

    DeviceUtils.hideKeyboard(context);
    return Material(
        color: color,
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
                flex: 3, child: Center(child: Padding(padding: const EdgeInsets.fromLTRB(10, 45, 10, 5), child: _getCaption(theme, isDarkMode)))),
            Expanded(flex: 8, child: FractionallySizedBox(heightFactor: 0.6, widthFactor: 0.6, alignment: Alignment.topCenter, child: image)),
            Expanded(
                flex: 1,
                child: Stack(children: <Widget>[
                  Center(child: Text('ONE FRIEND STUDIO', style: studioStyle)),
                  Container(alignment: Alignment.bottomRight, child: imageLogo)
                ]))
          ],
        )));
  }

  Widget _getCaption(ThemeData theme, bool isDarkMode) {
    const double textScaleFactor = 45;
    const double textScaleFactor1 = 30;
    final TextStyle style = theme.textTheme.caption
        .copyWith(fontSize: DeviceUtils.getScaledText(context, textScaleFactor), color: isDarkMode ? Colors.white60 : Colors.black54);

    bool isRussian = false;
    if (UnitConverterApp.settings != null && UnitConverterApp.settings.locale != null) {
      isRussian = UnitConverterApp.settings.locale.languageCode == 'ru';
    } else {
      final Locale currentLocale = Localizations.localeOf(context);
      isRussian = currentLocale.languageCode == 'ru';
    }

    if (isRussian) {
      return FittedBox(child: Column(children: <Widget>[Text('КОНВЕРТЕР', style: style), Text('ЕДИНИЦ', style: style)]));
    }

    final TextStyle style1 = theme.textTheme.caption
        .copyWith(fontSize: DeviceUtils.getScaledText(context, textScaleFactor1), color: isDarkMode ? Colors.white60 : Colors.black54);
    return FittedBox(child: Column(children: <Widget>[
      FittedBox(child: Row(children: <Widget>[Text('just', style: style1), Text(' UNIT      ', style: style)])),
      Text('CONVERTER', style: style)
    ]));
  }

  /// Naviage to main page function
  void _navigate() {
    Navigator.of(context).pushReplacementNamed(Routes.main_page);
  }
}
