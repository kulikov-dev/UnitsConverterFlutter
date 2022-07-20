import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Class for working with user preferences
class SharedPrefsHelper {
  /// Load user preferences
  static Future<dynamic> loadPrefs(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString(key);
    if (jsonString == null) {
      return jsonString;
    }
    return json.decode(jsonString);
  }

  /// Save user preferences
  static Future<SharedPreferences> savePrefs(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
    return prefs;
  }
}