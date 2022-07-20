import 'package:unit/data/measure_mixin.dart';

class KilometerPerLiterConverter extends MeasureDelegate {
  @override
  double convert(double value) {
    return 100 / value;
  }

  @override
  double reverseConvert(double value) {
    return 100 * value;
  }
}
