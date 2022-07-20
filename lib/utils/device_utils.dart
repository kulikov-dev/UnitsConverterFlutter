import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
/// Helper class for device related operations.
class DeviceUtils {
  /// Flag for snack bar is showing to prevent multiple shack bards
  static bool isSnackBarActive = false;

  ///
  /// hides the keyboard if its already open
  ///
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// orientation
  ///
  static double getScaledSize(BuildContext context, double scale) =>
      scale * (MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height);

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// width
  ///
  static double getScaledWidth(BuildContext context, double scale) => scale * MediaQuery.of(context).size.width;

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// height
  ///
  static double getScaledHeight(BuildContext context, double scale) => scale * MediaQuery.of(context).size.height;

  ///
  /// accepts a double [scale] and returns scaled font size
  /// font size
  ///
  static double getScaledText(BuildContext context, double scale) => scale * MediaQuery.of(context).textScaleFactor;

  /// Show snackbar, cap
  static void showSnackbar(BuildContext context, String snackBarText, Function function, bool needContext) {
    if (!isSnackBarActive) {
      isSnackBarActive = true;
      final ThemeData theme = Theme.of(context);
      final SnackBar snackBar = SnackBar(
        content: Text(snackBarText, textAlign: TextAlign.center, style: theme.textTheme.bodyText1),
        backgroundColor: theme.backgroundColor,
        duration: const Duration(milliseconds: 1500),
      );

      Scaffold.of(context).showSnackBar(snackBar).closed.then((_) {
        if (function != null) {
          if (needContext) {
            function(context);
          } else {
            function();
          }
        }
        isSnackBarActive = false;
      });
    }
  }

  /// Check if current theme mode is dark mode
  static bool isDarkMode(BuildContext context) {
    final Brightness brightnessValue = WidgetsBinding.instance.window.platformBrightness;
    return brightnessValue == Brightness.dark;
  }
}