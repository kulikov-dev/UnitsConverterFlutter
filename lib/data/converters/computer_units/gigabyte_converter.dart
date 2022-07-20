import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

/// Converter of gigabyte measure
class GigabyteConverter extends MeasureDelegate {
  /// Convert to gigabyte
  @override
  double convert(double value) {
    return value * pow(2,-10);
  }

  /// Convert from gigabyte
  @override
  double reverseConvert(double value) {
    return value / pow(2,-10);
  }
}