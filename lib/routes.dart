import 'package:flutter/material.dart';
import 'package:unit/widgets/converter/converter_widget.dart';
import 'package:unit/widgets/main/main_page.dart';
import 'package:unit/widgets/settings_widget.dart';
import 'package:unit/widgets/splash_screen.dart';

/// Navigator support class to provide link to routes
class Routes {
  Routes._();

  /// Link to splash page
  static const String splash = '/splash';

  /// Link to main page
  static const String main_page = '/main_page';

  /// Link to converter page
  static const String converter = '/converter';

  /// Link to settings page
  static const String settings = '/settings';

  /// Links map
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    main_page: (BuildContext context) => MainPage(),
    converter: (BuildContext context) => ConverterWidget(),
    settings: (BuildContext context) => SettingsWidget(),
  };
}