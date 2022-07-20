import 'package:unit/data/measure_mixin.dart';

class FahrenheitConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return (value * (9 / 5)) - 459.67;
  }

  @override
  double reverseConvert(double value) {
    return (value / (9 / 5)) + 459.67;
  }
}
