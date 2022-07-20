import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

class TerabyteConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return value * pow(2,-20);
  }

  @override
  double reverseConvert(double value) {
    return value / pow(2,-20);
  }
}
