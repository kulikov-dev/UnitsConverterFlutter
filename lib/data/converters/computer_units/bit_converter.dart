import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

/// Converter of bit measure
class BitConverter extends MeasureDelegate {
  /// Convert to bit
  @override
  double convert(double value) {
    return value * pow(2,30);
  }

  /// Convert from bit
  @override
  double reverseConvert(double value) {
    return value / pow(2,30);
  }
}