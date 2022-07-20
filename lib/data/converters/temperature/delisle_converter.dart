import 'package:unit/data/measure_mixin.dart';

class DelisleConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return (373.15 - value) * (3 / 2);
  }

  @override
  double reverseConvert(double value) {
    return (373.15 + value) / (3 / 2);
  }
}
