import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

class RadianConverter extends MeasureDelegate {
  static const double _piD = pi / 180;

  @override
  double convert(double value) {
    return value * _piD;
  }

  @override
  double reverseConvert(double value) {
    return value / _piD;
  }
}
