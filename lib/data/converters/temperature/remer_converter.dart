import 'package:unit/data/measure_mixin.dart';

class RemerConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return (value - 273.15) * (21 / 40) + 7.5;
  }

  @override
  double reverseConvert(double value) {
    return (value + 273.15) / (21 / 40) - 7.5;
  }
}
