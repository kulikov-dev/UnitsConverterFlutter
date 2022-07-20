import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unit/unit_converter_app.dart';

/// Entry point of app
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    UnitConverterApp.settings.loadSettings().then((_) => runApp(UnitConverterApp()));
  });
}