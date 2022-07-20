import 'dart:math';

import 'package:unit/data/measure_mixin.dart';

class PetabyteConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return value * pow(2,-30);
  }

  @override
  double reverseConvert(double value) {
    return value / pow(2,-30);
  }
}
