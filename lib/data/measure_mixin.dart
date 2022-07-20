/// Delegate to custom measure recalculation
abstract class MeasureDelegate {
  /// Convert to measure unit
  double convert(double value);

  /// Convert from measure unit
  double reverseConvert(double value);
}
