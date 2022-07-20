import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unit/constants/app_theme.dart';
import 'package:unit/constants/colors.dart';
import 'package:unit/constants/enums.dart';
import 'package:unit/data/measure.dart';
import 'package:unit/data/settings.dart';
import 'package:unit/routes.dart';
import 'package:unit/utils/app_localization.dart';
import 'package:unit/utils/device_utils.dart';
import 'package:unit/utils/type_helpers.dart';
import 'package:unit/widgets/splash_screen.dart';

/// Main app widget
class UnitConverterApp extends StatefulWidget {
  /// Constructor
  UnitConverterApp({Key key}) : super(key: key);

  /// Link to settings info
  static Settings settings = Settings();

  static bool isDarkMode;

  /// Flag of necessity of widgets update
  static bool needUpdateWidgets = true;

  @override
  UnitConverterAppState createState() => UnitConverterAppState();
}

/// Main app widget state
class UnitConverterAppState extends State<UnitConverterApp> with WidgetsBindingObserver {
  /// Visual theme
  final ThemeData _appTheme = AppTheme.buildAppLightTheme();
  final ThemeData _appDarkTheme = AppTheme.buildAppDarkTheme();

  /// On locale changed
  void changeLocale() {
    setState(() {});
  }

  void changeTheme() {
    didChangePlatformBrightness();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (UnitConverterApp.settings.themeStyle != ThemeStyleEnum.System) {
      UnitConverterApp.isDarkMode = UnitConverterApp.settings.themeStyle == ThemeStyleEnum.Dark;
    } else {
      UnitConverterApp.isDarkMode = DeviceUtils.isDarkMode(context);
    }

    final Brightness brightness = UnitConverterApp.isDarkMode ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.primaryDarkColor,
      // navigation bar color
      statusBarBrightness: Brightness.dark,
      //status bar brigtness
      statusBarIconBrightness: brightness,
      //status barIcon Brightness
      systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icon
    ));

    for (MeasureInfo value in measuresInfo.values) {
      value.updateImage();
    }

    UnitConverterApp.needUpdateWidgets = true;
    setState(() {});
  }

  bool needPrecached = true;

  static void precache_measures(BuildContext context) async {
    for (int i = 0; i < MeasureCategoriesEnum.values.length; ++i) {
      final MeasureCategoriesEnum category = MeasureCategoriesEnum.values[i];
      final List<MeasuresEnum> measures = categories[category];
      for (MeasuresEnum measure in measures) {
        final String caption = TypeHelpers.getEnumCaption(measure);
        final MeasureCategoriesEnum category =
            categories.keys.firstWhere((MeasureCategoriesEnum k) => categories[k].contains(measure), orElse: () => null);
        precacheImage(AssetImage('Resources/Images/Measures/' + TypeHelpers.getEnumCaption(category) + '/' + caption + '.png'), context);
      }
    }
  }

  /// Build widget
  @override
  Widget build(BuildContext context) {
    DeviceUtils.hideKeyboard(context);
    precacheImage(const AssetImage('Resources/Images/splash.png'), context);
    precacheImage(const AssetImage('Resources/Images/logo.png'), context);

    if (needPrecached) {
      precache_measures(context);
      UnitConverterApp.settings.loadFavorites();

      needPrecached = false;
    }

    return MaterialApp(
      onGenerateTitle: (BuildContext context) {
        final AppLocalizations locale = AppLocalizations.of(context);
        return locale.translate('AppTitle');
      },
      theme: UnitConverterApp.isDarkMode ? _appDarkTheme : _appTheme,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
        // Built-in localization of basic text for Cupertino widgets
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[Locale('en', ''), Locale('ru', '')],
      locale: UnitConverterApp.settings.locale,
      home: SplashScreen(),
    );
  }
}
