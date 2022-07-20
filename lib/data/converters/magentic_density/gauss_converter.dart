import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

class GaussConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return value * pow(10,4);
  }

  @override
  double reverseConvert(double value) {
    return value / pow(10,4);
  }
}
