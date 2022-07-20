import 'package:unit/data/measure_mixin.dart';

class NewtonConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return (value - 273.15) * (33 / 100);
  }

  @override
  double reverseConvert(double value) {
    return (value + 273.15) / (33 / 100);
  }
}
