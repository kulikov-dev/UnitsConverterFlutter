/// Helper for different types
class TypeHelpers {
  /// Check if string contains string2 ignore case
  static bool containsIgnoreCase(String string1, String string2) {
    if (string1 == null || string2 == null) {
      return false;
    }

    return string1.toLowerCase().contains(string2.toLowerCase());
  }

  /// Get caption from enum
  static String getEnumCaption(dynamic unit) {
    return unit.toString().split('.').last;
  }
}