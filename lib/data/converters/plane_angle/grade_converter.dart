import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

class GradeConverter extends MeasureDelegate {
  static const double _piD = pi / 180;

  @override
  double convert(double value) {
    return tan(value * _piD) * 100;
  }

  @override
  double reverseConvert(double value) {
    return (1 / tan(value * _piD)) / 100;
  }
}
