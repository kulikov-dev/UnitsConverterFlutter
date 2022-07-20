import 'package:flutter/material.dart';
import 'package:unit/constants/colors.dart';

/// Application theme
class AppTheme {
  /// Constructor
  AppTheme._();

  /// Get app light theme
  static ThemeData buildAppLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        backgroundColor: Colors.white70,
        primaryColor: AppColors.primaryLightColor,
        accentColor: AppColors.accentLightColor,
        secondaryHeaderColor: AppColors.secondaryLightColor,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textSelectionColor: AppColors.primaryLightColor,
        errorColor: Colors.red,
        highlightColor: AppColors.accentLightColor,
        splashColor: Colors.transparent,
        textSelectionHandleColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(200, 255, 255, 255)
        ),
        textTheme: _buildTextTheme(base.textTheme, false));
  }

  /// Get app dark theme
  static ThemeData buildAppDarkTheme() {
    final ThemeData base = ThemeData.dark();
    const Color backgroundColor = Color.fromARGB(255, 18, 18, 18);
    return base.copyWith(
        backgroundColor: backgroundColor,
        primaryColor: AppColors.primaryDarkColor,
        accentColor: AppColors.accentDarkColor,
        secondaryHeaderColor: AppColors.secondaryDarkColor,
        scaffoldBackgroundColor: backgroundColor,
        cardColor: backgroundColor,
        textSelectionColor: AppColors.primaryDarkColor,
        errorColor: Colors.red,
        highlightColor: AppColors.accentDarkColor,
        splashColor: Colors.transparent,
        textSelectionHandleColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white54,
        ),
        textTheme: _buildTextTheme(base.textTheme, true));
  }

  /// Get text theme
  static TextTheme _buildTextTheme(TextTheme base, bool isDarkTheme) {
    return base
        .copyWith(
          bodyText1: base.bodyText1
              .copyWith(fontWeight:isDarkTheme? FontWeight.w300 :  FontWeight.w400, color: isDarkTheme ? Colors.white60 : Colors.black54),
          bodyText2: base.bodyText2
              .copyWith(fontWeight: isDarkTheme? FontWeight.w400 : FontWeight.w500, color: isDarkTheme ? Colors.white60 : Colors.black54),
          caption: base.caption.copyWith(
              fontWeight: isDarkTheme? FontWeight.w500 : FontWeight.w600, fontSize: 20, color: isDarkTheme ? Colors.white60 : Colors.black54),
        )
        .apply(
          fontFamily: 'Roboto',
        );
  }
}
