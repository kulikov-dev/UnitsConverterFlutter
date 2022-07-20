import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

/// Converter of byte measure
class ByteConverter extends MeasureDelegate {
  /// Convert to byte
  @override
  double convert(double value) {
    return value * pow(2,20);
  }

  /// Convert from byte
  @override
  double reverseConvert(double value) {
    return value / pow(2,20);
  }
}