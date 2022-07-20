import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unit/constants/colors.dart';
import 'package:unit/constants/enums.dart';
import 'package:unit/unit_converter_app.dart';
import 'package:unit/utils/measure_converter.dart';
import 'package:unit/utils/shared_prefs_helper.dart';
import 'package:unit/utils/type_helpers.dart';

/// Information about measure
class MeasureInfo {
  /// Constructor
  MeasureInfo(this.measure, this.baseMeasureUnit, this.measureUnits) {
    lastFromMeasureUnit = baseMeasureUnit;
    _updateLastToMeasureUnit();
  }

  /// Link to image widget of measure
  Image imageWidget;

  /// Base measure unit
  MeasureUnitsEnum baseMeasureUnit;

  /// List of measure units
  Map<MeasureUnitsEnum, UnitConversionInfo> measureUnits;

  /// Measure
  MeasuresEnum measure;

  /// Is measure favorite
  bool isFavorite = false;

  /// Last converter From measure unit
  MeasureUnitsEnum lastFromMeasureUnit;

  /// Last converter To measure unit
  MeasureUnitsEnum lastToMeasureUnit;

  /// Last converter value
  String lastValue;

  /// Recreate image widget based on theme style
  void updateImage() {
    final String caption = TypeHelpers.getEnumCaption(measure);
    final MeasureCategoriesEnum category =
        categories.keys.firstWhere((MeasureCategoriesEnum k) => categories[k].contains(measure), orElse: () => null);

    imageWidget = Image.asset(
      'Resources/Images/Measures/' + TypeHelpers.getEnumCaption(category) + '/' + caption + '.png',
      fit: BoxFit.fitHeight,
      color: UnitConverterApp.isDarkMode ? AppColors.secondaryDarkColor : AppColors.primaryLightColor,
    );
  }

  /// Save class to JSON
  Map<String, dynamic> toJson() => <String, dynamic>{
        'isFavorite': isFavorite,
        'lastFromMeasureUnit': TypeHelpers.getEnumCaption(lastFromMeasureUnit),
        'lastToMeasureUnit': TypeHelpers.getEnumCaption(lastToMeasureUnit),
        'lastValue': lastValue,
      };

  /// Recreate last used measure unit
  void _updateLastToMeasureUnit() {
    if (lastToMeasureUnit != null) {
      return;
    }

    if (measureUnits.keys.length == 1) {
      lastToMeasureUnit ??= measureUnits.keys.last;
      return;
    }

    for (int i = 0; i < measureUnits.keys.length; ++i) {
      if (measureUnits.keys.elementAt(i) == baseMeasureUnit) {
        if (i == measureUnits.keys.length - 1) {
          lastToMeasureUnit = measureUnits.keys.elementAt(i - 1);
        } else {
          lastToMeasureUnit = measureUnits.keys.elementAt(i + 1);
        }

        return;
      }
    }

    lastToMeasureUnit ??= measureUnits.keys.last;
  }

  /// Read class from JSON
  void fromJson(Map<String, dynamic> json) {
    isFavorite = json['isFavorite'];
    lastFromMeasureUnit = measureUnitFromCaption(json['lastFromMeasureUnit']) ?? baseMeasureUnit;
    lastToMeasureUnit = measureUnitFromCaption(json['lastToMeasureUnit']);
    _updateLastToMeasureUnit();

    lastValue = json['lastValue'];
  }

  /// Save specific measure to JSON
  static void saveToJson(MeasuresEnum measure) {
    final Map<String, dynamic> result = measuresInfo[measure].toJson();
    final String jsonKey = TypeHelpers.getEnumCaption(measure);
    SharedPrefsHelper.savePrefs(jsonKey, result);
  }

  static MeasureUnitsEnum measureUnitFromCaption(String caption) {
    for (MeasureUnitsEnum unit in MeasureUnitsEnum.values) {
      if (unit.toString().contains(caption)) {
        return unit;
      }
    }

    return null;
  }
}

/// Arguments to pass info about selected category
class MeasureArguments {
  /// Constructor
  const MeasureArguments(this.measure);

  /// Selected category
  final MeasuresEnum measure;
}
