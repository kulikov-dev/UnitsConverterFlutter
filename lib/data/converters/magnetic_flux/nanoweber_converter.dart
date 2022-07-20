import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

class NanoweberConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return value * pow(10, 9);
  }

  @override
  double reverseConvert(double value) {
    return value / pow(10, 9);
  }
}
