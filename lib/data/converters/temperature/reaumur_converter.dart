import 'package:unit/data/measure_mixin.dart';

class ReaumurConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return (value - 273.15) * (4 / 5);
  }

  @override
  double reverseConvert(double value) {
    return (value + 273.15) / (4 / 5);
  }
}
