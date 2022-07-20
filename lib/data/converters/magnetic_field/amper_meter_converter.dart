import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

class AmperPerMeterConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return value * (1000 / (4 * pi));
  }

  @override
  double reverseConvert(double value) {
    return value / (1000 / (4 * pi));
  }
}
