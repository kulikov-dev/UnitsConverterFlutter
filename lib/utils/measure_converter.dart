import 'dart:math';

import 'package:unit/constants/enums.dart';
import 'package:unit/data/measure.dart';
import 'package:unit/data/measure_mixin.dart';
import 'package:unit/unit_converter_app.dart';

/// Temp class for unit convertion
/// Supposed to move to MeasureInfo, not sure
class MeasureConverter {
  /// Convert value based on measure info
  static String convert(MeasureInfo info) {
    double baseValue = double.tryParse(info.lastValue);
    if (baseValue == null || baseValue.isNaN) {
      return '';
    }

    UnitConversionInfo operatorInfo = info.measureUnits[info.lastFromMeasureUnit];
    if (info.lastFromMeasureUnit != info.baseMeasureUnit && operatorInfo != null) {
      if (operatorInfo.converter != null) {
        baseValue = operatorInfo.converter.reverseConvert(baseValue);
      } else if (operatorInfo.operator == OperatorEnum.Multiply) {
        baseValue /= operatorInfo.coefficient;
      } else if (operatorInfo.operator == OperatorEnum.Divide) {
        baseValue *= operatorInfo.coefficient;
      } else if (operatorInfo.operator == OperatorEnum.Minus) {
        baseValue += operatorInfo.coefficient;
      }
    }

    const int s = 5; // Количество значащих цифр
    operatorInfo = info.measureUnits[info.lastToMeasureUnit];
    double newValue;

    if (operatorInfo.converter != null) {
      newValue = operatorInfo.converter.convert(baseValue);
    } else if (operatorInfo.operator == OperatorEnum.Multiply) {
      newValue = baseValue * operatorInfo.coefficient;
    } else if (operatorInfo.operator == OperatorEnum.Divide) {
      newValue = baseValue / operatorInfo.coefficient;
    } else if (operatorInfo.operator == OperatorEnum.Minus) {
      newValue = baseValue - operatorInfo.coefficient;
    }

    final num bigValue = pow(10, 21);
    if (newValue > bigValue) {
      return newValue.toStringAsExponential(s);
    }

    return UnitConverterApp.settings.formatter.format(newValue);
  }
}

/// Arguments to pass info about selected category
class UnitConversionInfo {
  /// Base constructor
  const UnitConversionInfo(this.coefficient, this.symbol)
      : operator = OperatorEnum.Multiply,
        converter = null;

  /// Constructor with custom operator for conversion
  const UnitConversionInfo.full(this.coefficient, this.symbol, this.operator) : converter = null;

  /// Constructor to custom delegate conversion
  const UnitConversionInfo.delegate(this.symbol, this.converter)
      : coefficient = double.nan,
        operator = OperatorEnum.None;

  /// Conversion coefficient
  final double coefficient;

  /// Measure notification symbol
  final String symbol;

  /// Conversion operator
  final OperatorEnum operator;

  /// Custom conversion delegate
  final MeasureDelegate converter;
}