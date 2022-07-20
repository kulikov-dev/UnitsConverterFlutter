import 'dart:math';

import 'package:unit/data/converters/computer_units/bit_converter.dart';
import 'package:unit/data/converters/computer_units/byte_converter.dart';
import 'package:unit/data/converters/computer_units/gigabyte_converter.dart';
import 'package:unit/data/converters/computer_units/petabyte_converter.dart';
import 'package:unit/data/converters/computer_units/terabyte_converter.dart';
import 'package:unit/data/converters/fuel_consumption/kilometer_liter_converter.dart';
import 'package:unit/data/converters/light/wavelength_meter_converter.dart';
import 'package:unit/data/converters/magentic_density/gamma_converter.dart';
import 'package:unit/data/converters/magentic_density/gauss_converter.dart';
import 'package:unit/data/converters/magnetic_field/amper_meter_converter.dart';
import 'package:unit/data/converters/magnetic_flux/maxwell_converter.dart';
import 'package:unit/data/converters/magnetic_flux/nanoweber_converter.dart';
import 'package:unit/data/converters/plane_angle/grade_converter.dart';
import 'package:unit/data/converters/plane_angle/milliradian_converter.dart';
import 'package:unit/data/converters/plane_angle/radian_converter.dart';
import 'package:unit/data/converters/radiation/banana_converter.dart';
import 'package:unit/data/converters/radiation/radiation_converter.dart';
import 'package:unit/data/converters/temperature/delisle_converter.dart';
import 'package:unit/data/converters/temperature/fahrenheit_converter.dart';
import 'package:unit/data/converters/temperature/newton_converter.dart';
import 'package:unit/data/converters/temperature/reaumur_converter.dart';
import 'package:unit/data/converters/temperature/remer_converter.dart';
import 'package:unit/data/measure.dart';
import 'package:unit/utils/measure_converter.dart';

/// Enumeration of group separators
enum GroupSeparatorEnum { None, Space, Dot, Comma }

/// Enumeration of decimal separators
enum DecimalSeparatorEnum { Dot, Comma }

/// Enumeration of unit format
enum UnitsFormatEnum {Full, Symbol }

/// Enumeration of operators
enum OperatorEnum { None, Multiply, Divide, Minus }

/// Enumeration of theme styles
enum ThemeStyleEnum { Light, Dark, System }

/// Enumeration of measures categories
enum MeasureCategoriesEnum {
  BaseUnits,
  SpaceAndTime,
  Mechanics,
  ComputerUnits,
  Magnetism,
  Light,
  Radiation,
  HeatFlowrate,
  Astronomical,
  Chemistry,
  ObsoleteRussian
}

/// Enumeration of measures
enum MeasuresEnum {
  // Base units
  Distance,
  Mass,
  Time,
  Temperature,
  ElectricCurrent,
  Substance,
  Luminous,
  // SpaceAndTime
  Area,
  Volume,
  MedicineVolume,
  MassFlow,
  SpeedVelocity,
  RotationalSpeed,
  Acceleration,
  FuelConsumption,
  PlaneAngle,
  VolumetricLiquidFlow,
  VolumetricGasFlow,
  // Mechanics
  Energy,
  Power,
  Force,
  HighPressure,
  LowPressure,
  DynamicViscosity,
  KinematicViscosity,
  Torque,
  Density,
  Inertia,
  // Computer units
  DataSize,
  DataTransferRate,
  ImageResolution,
  // Magnetism
  MagneticField,
  MagneticFlux,
  MagneticDensity,
  ElectricCharge,
  Resistivity,
  Conductivity,
  // Light
  Wavelength,
  Luminance,
  Illuminance,
  // Radiation
  AbsorbedDose,
  Activity,
  DoseEquivalent,
  Exposure,
  //HeatFlowrate
  ThermalConductivity,
  HeatCapacity,
  HeatOfCombustionMass,
  HeatOfCombustionVolume,
  // Astronomical
  AstroLength,
  AstroMass,
  // Chemistry
  MolarVolume,
  MolarMass,
  MassConcentration,
  HardWater,
  // ObsoleteRussian
  DistanceOr,
  MassOr,
  DryVolumeOr,
  LiquidVolumeOr,
}

/// Enumeration of all measure units for all measures
enum MeasureUnitsEnum {
  //// Base units
  // Distance
  Millimeter,
  Centimetre,
  Meter,
  Kilometre,
  Inches,
  Feet,
  Yard,
  Mile,
  NauticalMile,
  // Mass
  Milligram,
  Gram,
  Kilogram,
  MetricTonnes,
  ShortTon,
  LongTon,
  Pounds,
  Ounces,
  Grain,
  Stone,
  // Time
  Millisecond,
  Second,
  Minute,
  Hour,
  Day,
  Week,
  Month,
  Year,
  JulianYear,
  // Temperature
  Kelvin,
  Celsius,
  Fahrenheit,
  Rankine,
  Delisle,
  Newton,
  Reaumur,
  Remer,
  // Electric current
  Milliampere,
  Ampere,
  AbAmpere,
  Kiloampere,
  // Substance
  Millimole,
  Mole,
  GramMole,
  Kilomole,
  PoundMole,
  // Luminous
  Candela,

  //// SpaceAndTime
  // Area
  MillimeterSquare,
  CentimeterSquare,
  MeterSquare,
  KilometerSquare,
  InchSquare,
  FootSquare,
  YardSquare,
  MileSquare,
  Hectare,
  Acre,
  // Volume
  Milliliter,
  CubicCentimeter,
  CubicMetre,
  Litre,
  Centilitre,
  CubicInch,
  CubicFoot,
  CubicYard,
  USGallons,
  ImperialGallons,
  USBarrel,
// Medical volume
  DropOfWater,
  DropOfAlcohol,
  Teaspoon,
  Tablespoon,
  // Mass flow
  Kilogram_hour,
  Pound_hour,
  Kilogram_second,
  Ton_hour,
  // Speed velocity
  Meter_second,
  Meter_minute,
  Kilometer_hour,
  Miles_hour,
  Foot_second,
  Foot_minute,
  Knot_hour,
  // Rotational speed
  Rotation_minute,
  Cycles_second,
  Radian_second,
  // Acceleration
  Gal,
  Meter_secondSquare,
  Inch_secondSquare,
  Foot_secondSquare,
  Gravity,
  // Fuel consumption
  Liters_Km,
  Miles_Gallon_US,
  Miles_Gallon_Imp,
  Kilometer_liter,
  // Plane angle
  Grad,
  Degree,
  Radian,
  Arcminute,
  Arcsecond,
  Milliradian,
  Grade,
  // Volumetric liquid flow
  Liter_second,
  Liter_minute,
  MeterCube_min,
  MeterCube_hour,
  FootCube_minute,
  FootCube_hour,
  Gallons_minute,
  Barrels_day,
  // Volumetric gas flow
  NormalMeterCube_hour,
  StandardCubicFeet_hour,
  StandardCubicFeet_minute,

  //// Mechanics
  // Energy
  Joule,
  Kiljoule,
  Megajoule,
  GramCalorie,
  Kilocalorie,
  WattHour,
  KilowattHour,
  BritishThermalUnit,
  FootPoundForce,
  // Power
  Watt,
  Kilowatt,
  Megawatt,
  Calorie_second,
  BTU_second,
  BTU_hour,
  MechanicalHorsepower,
  MetricHorsepower,
  KilovoltAmps,
  // Force
  NewtonForce,
  Dyne,
  KilogramForce,
  PoundForce,
  Poundal,
  TonForce,
  Kip,
  JouleMetre,
  // HighPressure
  Millibar,
  Bar,
  Pound_SquareInch,
  Pounds_SquareFoot,
  Kilopascal,
  Megapascal,
  Atmospheres,
  KilogramForce_CentimetreSquare,
  MillimetreMercury,
  Torr,
  // LowPressure
  MetreWater,
  FootWater,
  CentimetreMercury,
  InchesMercury,
  InchesWater,
  Pascal,
  // DynamicViscosity
  Centipoise,
  MillipascalSecond,
  Poise,
  PascalSecond,
  Pound_FootSecond,
  // KinematicViscosity
  Centistoke,
  Stoke,
  FootSquaref_Second,
  MetreSquare_Second,
  // Torque
  NewtonMillimetre,
  NewtonCentimetre,
  NewtonMetre,
  KilogramForceMetre,
  FootPound,
  InchPound,
  // Density
  Gramm_MetreCube,
  Kilogram_MetreCube,
  Gramm_CentimetreCube,
  Gram_Milliliter,
  Pound_FootCube,
  Pound_InchCube,
  // Inertia
  KilogramSquareMetre,
  PoundSquareFoot,

  //// Computer units
  // Data size
  Bit,
  Byte,
  Kilobyte,
  Megabyte,
  Gigabyte,
  Terabyte,
  Petabyte,
  // Data transfer size
  BitsPerSecond,
  BytesPerSecond,
  KilobitsPerSecond,
  KilobytesPerSecond,
  MegabitsPerSecond,
  MegabytesPerSecond,
  GigabitsPerSecond,
  GigabytesPerSecond,
  // Image resolution
  DotPerMillimetre,
  DotPerInch,
  PixelPerCentimetre,
  PixelPerInch,
  DotPerMetre,

  // Electricity and magnetism
  // Magnetic field
  Orsted,
  Amper_metre,
  // Magnetic flex
  Maxwell,
  Nanoweber,
  Weber,
  // Magnetic density
  Gamma,
  Gauss,
  Tesla,
  // Electric charge
  Coulomb,
  MilliampereHour,
  AmpereHour,
  // Resistivity
  CircularMil,
  NanoohmMetre,
  OhmMetre,
  // Conductivity
  SiemensPerMetre,
  MhoPerCentimetre,

  // Light
  // Wavelength
  Angstrom,
  Nanometre,
  Mircometre,
  // Luminance
  Lambert,
  Candela_SquareInch,
  Footlambert,
  Candela_SquareMetre,
  // Illuminance
  CentimetreCandle,
  Flame,
  Footcandle,
  Lumen_SquareCentimetre,
  Lumen_SquareFoot,
  Lumen_SquareMetre,
  Lux,
  MetreCandle,
  Nox,

  // Radiation
  // AbsorbedDose,
  Curie,
  Becquerel,
  Rutherford,
  // Activity,
  ErgPerGram,
  Rad,
  Gray,
  Centigray,
  // DoseEquivalent,
  RoentgenEquivalent,
  BananaEquivalent,
  Millirem,
  Sievert,
  Millisievert,
  Microsievert,
  // Exposure,
  Roentgen,
  Coulomb_kilogram,

  //// Astronomical
  // Mass
  SolarMass,
  JupiterMasses,
  EarthMasses,
  // Length
  LunarDistance,
  AstronomicalUnits,
  Gigametres,
  Parsecs,
  LightYears,
  Kiloparsecs,
  Megaparsecs,

  //// Chemistry
  // Molar volume
  Litre_mole,
  CubicDecimetres_mole,
  CubicCentimetres_mole,
  CubicMetres_mole,
  Molar,
  // Molar mass
  Kilogram_mole,
  Gram_mole,
  Pound_mole,
  // Mass concentration
  Milligram_litre,
  Gram_litre,
  Gram_100milliliters,
  // Hard water
  Micromolle_litre,
  Parts_million,
  DegreeHardness,
  DegreeGeneralHardness,
  Grains_gallon,
  EnglishDegrees,
  FrenchDegrees,

  //// ObsoleteRussian
  // DistanceOr
  Vershok,
  Ladon,
  Pyad,
  Fut,
  Lokot,
  Arshin,
  Sazhen,
  Versta,
  // MassOr
  Dolya,
  Zolotnik,
  Lot,
  Funt,
  Pood,
  Berkovets,
  // DryVolumeOr
  Chast,
  Kruzhka,
  Garnec,
  Vedro,
  Chetverik,
  Osmina,
  Chetvert,
  //LiquidVolumeOr
  Shkalik,
  Charka,
  Butylka,
  Shtof,
  Bochka,

  //// HeatFlowrate
  // ThermalConductivity
  Watt_MetreKelvin,
  BTU_per_hftFarengeit,
  // HeatCapacity
  BTU_Fahrenheit,
  Kilojoule_kelvin_kilogram,
  Joule_Celsius_kilogram,
  Joule_kelvin_kilogram,
  SmallCalorie,
  LargeCalorie,
  // HeatOfCombustionMass
  Joule_CubicMetre,
  MegaJoule_CubicMetre,
  BTU_CubicFoot,
  // HeatOfCombustionVolume
  Joule_Kilogram,
  MegaJoule_Kilogram,
  BTU_Pound,
  KiloCalories_Kilogram,
}

/// Map to define measures to categories
Map<MeasureCategoriesEnum, List<MeasuresEnum>> categories = <MeasureCategoriesEnum, List<MeasuresEnum>>{
  MeasureCategoriesEnum.BaseUnits: <MeasuresEnum>[
    MeasuresEnum.Distance,
    MeasuresEnum.Mass,
    MeasuresEnum.Time,
    MeasuresEnum.Temperature,
    MeasuresEnum.ElectricCurrent,
    MeasuresEnum.Substance,
   // MeasuresEnum.Luminous
  ],
  MeasureCategoriesEnum.SpaceAndTime: <MeasuresEnum>[
    MeasuresEnum.Area,
    MeasuresEnum.Volume,
    MeasuresEnum.MedicineVolume,
    MeasuresEnum.MassFlow,
    MeasuresEnum.SpeedVelocity,
    MeasuresEnum.RotationalSpeed,
    MeasuresEnum.Acceleration,
    MeasuresEnum.FuelConsumption,
    MeasuresEnum.PlaneAngle,
    MeasuresEnum.VolumetricLiquidFlow,
    MeasuresEnum.VolumetricGasFlow,
  ],
  MeasureCategoriesEnum.Mechanics: <MeasuresEnum>[
    MeasuresEnum.Energy,
    MeasuresEnum.Power,
    MeasuresEnum.Force,
    MeasuresEnum.HighPressure,
    MeasuresEnum.LowPressure,
    MeasuresEnum.DynamicViscosity,
    MeasuresEnum.KinematicViscosity,
    MeasuresEnum.Torque,
    MeasuresEnum.Density,
    MeasuresEnum.Inertia,
  ],
  MeasureCategoriesEnum.ComputerUnits: <MeasuresEnum>[
    MeasuresEnum.DataSize,
    MeasuresEnum.DataTransferRate,
    MeasuresEnum.ImageResolution
  ],
  MeasureCategoriesEnum.Magnetism: <MeasuresEnum>[
    MeasuresEnum.MagneticField,
    MeasuresEnum.MagneticFlux,
    MeasuresEnum.MagneticDensity,
    MeasuresEnum.ElectricCharge,
    MeasuresEnum.Resistivity,
    MeasuresEnum.Conductivity
  ],
  MeasureCategoriesEnum.Light: <MeasuresEnum>[
    MeasuresEnum.Wavelength,
    MeasuresEnum.Luminance,
    MeasuresEnum.Illuminance
  ],
  MeasureCategoriesEnum.Radiation: <MeasuresEnum>[
    MeasuresEnum.Activity,
    MeasuresEnum.AbsorbedDose,
    MeasuresEnum.DoseEquivalent,
    MeasuresEnum.Exposure
  ],
  MeasureCategoriesEnum.HeatFlowrate: <MeasuresEnum>[
    MeasuresEnum.ThermalConductivity,
    MeasuresEnum.HeatCapacity,
    MeasuresEnum.HeatOfCombustionMass,
    MeasuresEnum.HeatOfCombustionVolume
  ],
  MeasureCategoriesEnum.Astronomical: <MeasuresEnum>[
    MeasuresEnum.AstroLength,
    MeasuresEnum.AstroMass,
  ],
  MeasureCategoriesEnum.Chemistry: <MeasuresEnum>[
    MeasuresEnum.MolarVolume,
    MeasuresEnum.MolarMass,
    MeasuresEnum.MassConcentration,
    MeasuresEnum.HardWater,
  ],
  MeasureCategoriesEnum.ObsoleteRussian: <MeasuresEnum>[
    MeasuresEnum.DistanceOr,
    MeasuresEnum.MassOr,
    MeasuresEnum.DryVolumeOr,
    MeasuresEnum.LiquidVolumeOr
  ],
};

/// First version of map for measures and measure units info
Map<MeasuresEnum, MeasureInfo> measuresInfo = <MeasuresEnum, MeasureInfo>{
  //// Base units
  MeasuresEnum.Distance:
      MeasureInfo(MeasuresEnum.Distance, MeasureUnitsEnum.Meter, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Millimeter: const UnitConversionInfo(1000, 'mm'),
    MeasureUnitsEnum.Centimetre: const UnitConversionInfo(100, 'cm'),
    MeasureUnitsEnum.Meter: const UnitConversionInfo(1, 'm'),
    MeasureUnitsEnum.Kilometre: const UnitConversionInfo(0.001, 'km'),
    MeasureUnitsEnum.Inches: const UnitConversionInfo(39.37008, 'in'),
    MeasureUnitsEnum.Feet: const UnitConversionInfo(3.28084, 'ft'),
    MeasureUnitsEnum.Yard: const UnitConversionInfo(1.093613, 'yd'),
    MeasureUnitsEnum.Mile: const UnitConversionInfo(0.000621, 'ml'),
    MeasureUnitsEnum.NauticalMile: const UnitConversionInfo.full(1852, 'NM', OperatorEnum.Divide),
  }),
  MeasuresEnum.Mass: MeasureInfo(MeasuresEnum.Mass, MeasureUnitsEnum.Kilogram, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Milligram: UnitConversionInfo(pow(10.0, 6), 'mg'),
    MeasureUnitsEnum.Gram: const UnitConversionInfo(1000, 'g'),
    MeasureUnitsEnum.Kilogram: const UnitConversionInfo(1, 'kg'),
    MeasureUnitsEnum.MetricTonnes: const UnitConversionInfo(0.001, 't'),
    MeasureUnitsEnum.ShortTon: const UnitConversionInfo.full(907, 'shton', OperatorEnum.Divide),
    MeasureUnitsEnum.LongTon: const UnitConversionInfo.full(1016, 'Lton', OperatorEnum.Divide),
    MeasureUnitsEnum.Pounds: const UnitConversionInfo(2.204586, 'lb'),
    MeasureUnitsEnum.Ounces: const UnitConversionInfo(35.27337, 'oz'),
    MeasureUnitsEnum.Grain: const UnitConversionInfo.full(0.00082, 'gr', OperatorEnum.Divide),
    MeasureUnitsEnum.Stone: const UnitConversionInfo.full(6.35, 'st', OperatorEnum.Divide),
  }),
  MeasuresEnum.Time: MeasureInfo(MeasuresEnum.Time, MeasureUnitsEnum.Day, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Millisecond: const UnitConversionInfo(5184000, 'ms'),
    MeasureUnitsEnum.Second: const UnitConversionInfo(86400, 's'),
    MeasureUnitsEnum.Minute: const UnitConversionInfo(1440, 'min'),
    MeasureUnitsEnum.Hour: const UnitConversionInfo(24, 'h'),
    MeasureUnitsEnum.Day: const UnitConversionInfo(1, 'd'),
    MeasureUnitsEnum.Week: const UnitConversionInfo.full(7, 'w', OperatorEnum.Divide),
    MeasureUnitsEnum.Month: const UnitConversionInfo.full(30, 'm', OperatorEnum.Divide),
    MeasureUnitsEnum.Year: const UnitConversionInfo.full(365, 'y', OperatorEnum.Divide),
    MeasureUnitsEnum.JulianYear: const UnitConversionInfo.full(365.24, '', OperatorEnum.Divide)
  }),
  MeasuresEnum.Temperature:
      MeasureInfo(MeasuresEnum.Temperature, MeasureUnitsEnum.Kelvin, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Kelvin: const UnitConversionInfo(1, 'temp_K'),
    MeasureUnitsEnum.Celsius: const UnitConversionInfo.full(273.15, 'temp_C', OperatorEnum.Minus),
    MeasureUnitsEnum.Fahrenheit: UnitConversionInfo.delegate('temp_F', FahrenheitConverter()),
    MeasureUnitsEnum.Rankine: const UnitConversionInfo(1.8, 'temp_Ra'),
    MeasureUnitsEnum.Delisle: UnitConversionInfo.delegate('temp_D', DelisleConverter()),
    MeasureUnitsEnum.Newton: UnitConversionInfo.delegate('temp_N', NewtonConverter()),
    MeasureUnitsEnum.Reaumur: UnitConversionInfo.delegate('temp_Ro', RemerConverter()),
    MeasureUnitsEnum.Remer: UnitConversionInfo.delegate('temp_Re', ReaumurConverter()),
  }),
  MeasuresEnum.ElectricCurrent:
      MeasureInfo(MeasuresEnum.ElectricCurrent, MeasureUnitsEnum.Ampere, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Milliampere: const UnitConversionInfo(1000, 'mA'),
    MeasureUnitsEnum.Ampere: const UnitConversionInfo(1, 'A'),
    MeasureUnitsEnum.AbAmpere: const UnitConversionInfo.full(10, 'abA', OperatorEnum.Divide),
    MeasureUnitsEnum.Kiloampere: const UnitConversionInfo.full(1000, 'kA', OperatorEnum.Divide)
  }),
  MeasuresEnum.Substance:
      MeasureInfo(MeasuresEnum.Substance, MeasureUnitsEnum.Mole, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Millimole: const UnitConversionInfo(1000, 'mmol'),
    MeasureUnitsEnum.Mole: const UnitConversionInfo(1, 'mol'),
    MeasureUnitsEnum.GramMole: const UnitConversionInfo(1, 'g-mol'),
    MeasureUnitsEnum.Kilomole: const UnitConversionInfo.full(1000, 'kmol', OperatorEnum.Divide),
    MeasureUnitsEnum.PoundMole: const UnitConversionInfo(0.002204622621849, 'lb-mol'),
  }),
 /* MeasuresEnum.Luminous: MeasureInfo(MeasuresEnum.Luminous, MeasureUnitsEnum.Candela,   //TODO
      <MeasureUnitsEnum, UnitConvertionInfo>{MeasureUnitsEnum.Candela: const UnitConvertionInfo(1, 'cd')}),*/

  //// Space and time
  MeasuresEnum.Area:
      MeasureInfo(MeasuresEnum.Area, MeasureUnitsEnum.MeterSquare, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.MillimeterSquare: const UnitConversionInfo(1000000, 'mm2'),
    MeasureUnitsEnum.CentimeterSquare: const UnitConversionInfo(10000, 'cm2'),
    MeasureUnitsEnum.MeterSquare: const UnitConversionInfo(1, 'm2'),
    MeasureUnitsEnum.KilometerSquare: const UnitConversionInfo.full(1000000, 'km2', OperatorEnum.Divide),
    MeasureUnitsEnum.InchSquare: const UnitConversionInfo(1550.003, 'in2'),
    MeasureUnitsEnum.FootSquare: const UnitConversionInfo(10.76391, 'ft2'),
    MeasureUnitsEnum.YardSquare: const UnitConversionInfo(1.19599, 'yd2'),
    MeasureUnitsEnum.MileSquare: const UnitConversionInfo.full(2590000, 'ml2', OperatorEnum.Divide),
    MeasureUnitsEnum.Hectare: const UnitConversionInfo.full(10000, 'ha', OperatorEnum.Divide),
    MeasureUnitsEnum.Acre: const UnitConversionInfo.full(4047, 'ac', OperatorEnum.Divide),
  }),
  MeasuresEnum.Volume: MeasureInfo(MeasuresEnum.Volume, MeasureUnitsEnum.Litre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Milliliter: const UnitConversionInfo(1000, 'ml'),
    MeasureUnitsEnum.CubicCentimeter: const UnitConversionInfo(1000, 'cm3'),
    MeasureUnitsEnum.CubicMetre: const UnitConversionInfo.full(1000, 'm3', OperatorEnum.Divide),
    MeasureUnitsEnum.Litre: const UnitConversionInfo(1, 'L'),
    MeasureUnitsEnum.Centilitre: const UnitConversionInfo(100, 'cL'),
    MeasureUnitsEnum.CubicInch: const UnitConversionInfo(61, 'in3'),
    MeasureUnitsEnum.CubicFoot: const UnitConversionInfo(0.035, 'ft3'),
    MeasureUnitsEnum.CubicYard: const UnitConversionInfo.full(765, 'yd3', OperatorEnum.Divide),
    MeasureUnitsEnum.USGallons: const UnitConversionInfo(0.264201, 'USGal'),
    MeasureUnitsEnum.ImperialGallons: const UnitConversionInfo.full(4.546, 'ImpGal', OperatorEnum.Divide),
    MeasureUnitsEnum.USBarrel: const UnitConversionInfo.full(159, 'USbrl', OperatorEnum.Divide),
  }),
  MeasuresEnum.MedicineVolume:
      MeasureInfo(MeasuresEnum.MedicineVolume, MeasureUnitsEnum.Milliliter, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.DropOfWater: const UnitConversionInfo(20, 'gt'),
    MeasureUnitsEnum.DropOfAlcohol: const UnitConversionInfo(40, 'gt'),
    MeasureUnitsEnum.Milliliter: const UnitConversionInfo(1, 'ml'),
    MeasureUnitsEnum.Teaspoon: const UnitConversionInfo.full(5, 'tsp', OperatorEnum.Divide),
    MeasureUnitsEnum.Tablespoon: const UnitConversionInfo.full(15, 'Tbsp', OperatorEnum.Divide),
  }),
  MeasuresEnum.MassFlow:
      MeasureInfo(MeasuresEnum.MassFlow, MeasureUnitsEnum.Kilogram_hour, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Kilogram_hour: const UnitConversionInfo(1, 'kg/h'),
    MeasureUnitsEnum.Pound_hour: const UnitConversionInfo(2.204586, 'lb/hour'),
    MeasureUnitsEnum.Kilogram_second: const UnitConversionInfo(0.000278, 'kg/s'),
    MeasureUnitsEnum.Ton_hour: const UnitConversionInfo.full(1000, 't/h', OperatorEnum.Divide),
  }),
  MeasuresEnum.SpeedVelocity:
      MeasureInfo(MeasuresEnum.SpeedVelocity, MeasureUnitsEnum.Kilometer_hour, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Meter_second: const UnitConversionInfo(0.2778, 'm/s'),
    MeasureUnitsEnum.Meter_minute: const UnitConversionInfo(16.66467, 'm/min'),
    MeasureUnitsEnum.Kilometer_hour: const UnitConversionInfo(1, 'km/h'),
    MeasureUnitsEnum.Miles_hour: const UnitConversionInfo(0.621477, 'ml/h'),
    MeasureUnitsEnum.Foot_second: const UnitConversionInfo(0.911417, 'ft/s'),
    MeasureUnitsEnum.Foot_minute: const UnitConversionInfo(54.68504, 'ft/min'),
    MeasureUnitsEnum.Knot_hour: const UnitConversionInfo(0.539957, 'kn'),
  }),
  MeasuresEnum.RotationalSpeed:
      MeasureInfo(MeasuresEnum.RotationalSpeed, MeasureUnitsEnum.Cycles_second, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Rotation_minute: const UnitConversionInfo(60, 'rpm'),
    MeasureUnitsEnum.Cycles_second: const UnitConversionInfo(1, 'cps'),
    MeasureUnitsEnum.Radian_second: const UnitConversionInfo(6.2832, 'rad/s'),
  }),
  MeasuresEnum.Acceleration: MeasureInfo(
      MeasuresEnum.Acceleration, MeasureUnitsEnum.Meter_secondSquare, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Gal: const UnitConversionInfo(100, 'cm/s2'),
    MeasureUnitsEnum.Meter_secondSquare: const UnitConversionInfo(1, 'm/s2'),
    MeasureUnitsEnum.Inch_secondSquare: const UnitConversionInfo.full(0.0254, 'in/s2', OperatorEnum.Divide),
    MeasureUnitsEnum.Foot_secondSquare: const UnitConversionInfo.full(0.3048, 'ft/s2', OperatorEnum.Divide),
    MeasureUnitsEnum.Gravity: const UnitConversionInfo.full(9.80665, 'g₀', OperatorEnum.Divide)
  }),
  MeasuresEnum.FuelConsumption:
      MeasureInfo(MeasuresEnum.FuelConsumption, MeasureUnitsEnum.Liters_Km, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Liters_Km: const UnitConversionInfo(1, 'L/100km'),
    MeasureUnitsEnum.Miles_Gallon_US: const UnitConversionInfo(235.2145, 'MPG(US)'),
    MeasureUnitsEnum.Miles_Gallon_Imp: const UnitConversionInfo(282.481, 'MPG(Imp)'),
    MeasureUnitsEnum.Kilometer_liter: UnitConversionInfo.delegate('km/L', KilometerPerLiterConverter()),
  }),
  MeasuresEnum.PlaneAngle:
      MeasureInfo(MeasuresEnum.PlaneAngle, MeasureUnitsEnum.Degree, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Grad: const UnitConversionInfo(1.111111111, 'g_ang'),
    MeasureUnitsEnum.Degree: const UnitConversionInfo(1, '°'),
    MeasureUnitsEnum.Radian: UnitConversionInfo.delegate('rad', RadianConverter()),
    MeasureUnitsEnum.Arcminute: const UnitConversionInfo(60, '′'),
    MeasureUnitsEnum.Arcsecond: const UnitConversionInfo(3600, '″'),
    MeasureUnitsEnum.Milliradian: UnitConversionInfo.delegate('mrad', MilliradianConverter()),
    MeasureUnitsEnum.Grade: UnitConversionInfo.delegate('%', GradeConverter()),
  }),
  MeasuresEnum.VolumetricLiquidFlow: MeasureInfo(
      MeasuresEnum.VolumetricLiquidFlow, MeasureUnitsEnum.Liter_minute, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Liter_second: const UnitConversionInfo(0.016666, 'L/sec'),
    MeasureUnitsEnum.Liter_minute: const UnitConversionInfo(1, 'L/min'),
    MeasureUnitsEnum.MeterCube_min: const UnitConversionInfo.full(1000, 'M3/min', OperatorEnum.Divide),
    MeasureUnitsEnum.MeterCube_hour: const UnitConversionInfo(0.06, 'M3/hr'),
    MeasureUnitsEnum.FootCube_minute: const UnitConversionInfo(0.035317, 'ft3/min'),
    MeasureUnitsEnum.FootCube_hour: const UnitConversionInfo(2.118577, 'ft3/hr'),
    MeasureUnitsEnum.Gallons_minute: const UnitConversionInfo(0.264162, 'gal/min'),
    MeasureUnitsEnum.Barrels_day: const UnitConversionInfo(9.057609, 'brl/d'),
  }),
  MeasuresEnum.VolumetricGasFlow: MeasureInfo(
      MeasuresEnum.VolumetricGasFlow, MeasureUnitsEnum.NormalMeterCube_hour, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.NormalMeterCube_hour: const UnitConversionInfo(1, 'Nm3/hr'),
    MeasureUnitsEnum.StandardCubicFeet_hour: const UnitConversionInfo(35.31073, 'scfh'),
    MeasureUnitsEnum.StandardCubicFeet_minute: const UnitConversionInfo(0.588582, 'scfm'),
  }),

  //// Mechanics
  MeasuresEnum.Energy:
      MeasureInfo(MeasuresEnum.Energy, MeasureUnitsEnum.Kiljoule, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Joule: const UnitConversionInfo(1000, 'j'),
    MeasureUnitsEnum.Kiljoule: const UnitConversionInfo(1, 'kj'),
    MeasureUnitsEnum.Megajoule: const UnitConversionInfo.full(10000, 'Mj', OperatorEnum.Divide),
    MeasureUnitsEnum.GramCalorie: const UnitConversionInfo.full(4.184, 'cal', OperatorEnum.Divide),
    MeasureUnitsEnum.Kilocalorie: const UnitConversionInfo.full(4184, 'kcal', OperatorEnum.Divide),
    MeasureUnitsEnum.WattHour: const UnitConversionInfo.full(3.6, 'W*h', OperatorEnum.Divide),
    MeasureUnitsEnum.KilowattHour: const UnitConversionInfo.full(3600, 'kW*h', OperatorEnum.Divide),
    MeasureUnitsEnum.BritishThermalUnit: const UnitConversionInfo.full(1.055, 'BTU', OperatorEnum.Divide),
    MeasureUnitsEnum.FootPoundForce: const UnitConversionInfo(737.562, 'ft-lbf'),
  }),
  MeasuresEnum.Power: MeasureInfo(MeasuresEnum.Power, MeasureUnitsEnum.Kilowatt, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Watt: const UnitConversionInfo(1000, 'W'),
    MeasureUnitsEnum.Kilowatt: const UnitConversionInfo(1, 'kW'),
    MeasureUnitsEnum.Megawatt: const UnitConversionInfo.full(1000, 'MW', OperatorEnum.Divide),
    MeasureUnitsEnum.Calorie_second: const UnitConversionInfo(238.85, 'cal/s'),
    MeasureUnitsEnum.BTU_second: const UnitConversionInfo(0.9478171203, 'BTU/s'),
    MeasureUnitsEnum.BTU_hour: const UnitConversionInfo(3412.142, 'BTU/hr'),
    MeasureUnitsEnum.MechanicalHorsepower: const UnitConversionInfo(1.341, 'mechanical hp'),
    MeasureUnitsEnum.MetricHorsepower: const UnitConversionInfo(1.3596, 'metric hp'),
    //   MeasureUnitsEnum.KilovoltAmps: const UnitConvertionInfo(1, 'kVA'),    //TODO это не готово. После релиза
  }),
  MeasuresEnum.Force:
      MeasureInfo(MeasuresEnum.Force, MeasureUnitsEnum.NewtonForce, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.NewtonForce: const UnitConversionInfo(1, 'N'),
    MeasureUnitsEnum.Dyne: const UnitConversionInfo(100000, 'dyn'),
    MeasureUnitsEnum.KilogramForce: const UnitConversionInfo.full(9.807, 'kp', OperatorEnum.Divide),
    MeasureUnitsEnum.PoundForce: const UnitConversionInfo.full(4.448, 'lbf', OperatorEnum.Divide),
    MeasureUnitsEnum.Poundal: const UnitConversionInfo(7.2330115, 'pdl'),
    MeasureUnitsEnum.TonForce: const UnitConversionInfo(0.0001124, 'ton'),
    MeasureUnitsEnum.Kip: const UnitConversionInfo(0.0002248, ''),
    MeasureUnitsEnum.JouleMetre: const UnitConversionInfo(1, 'J/m'),
  }),
  MeasuresEnum.HighPressure:
      MeasureInfo(MeasuresEnum.HighPressure, MeasureUnitsEnum.Atmospheres, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Millibar: const UnitConversionInfo(1013.25, 'mbar'),
    MeasureUnitsEnum.Bar: const UnitConversionInfo(1.01325, 'bar'),
    MeasureUnitsEnum.Pound_SquareInch: const UnitConversionInfo(14.69181, 'psi'),
    MeasureUnitsEnum.Pounds_SquareFoot: const UnitConversionInfo(2116.22, 'psf'),
    MeasureUnitsEnum.Kilopascal: const UnitConversionInfo(101.3, 'KPa'),
    MeasureUnitsEnum.Megapascal: const UnitConversionInfo(0.1013, 'MPa'),
    MeasureUnitsEnum.Atmospheres: const UnitConversionInfo(1, 'atm'),
    MeasureUnitsEnum.KilogramForce_CentimetreSquare: const UnitConversionInfo(1.032936, 'kgf/cm2'),
    MeasureUnitsEnum.MillimetreMercury: const UnitConversionInfo(759.769, 'mm Hg'),
    MeasureUnitsEnum.Torr: const UnitConversionInfo.full(760, '', OperatorEnum.Divide),
  }),
  MeasuresEnum.LowPressure:
      MeasureInfo(MeasuresEnum.LowPressure, MeasureUnitsEnum.Pascal, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.MetreWater: const UnitConversionInfo(0.000102, 'mH2O'),
    MeasureUnitsEnum.FootWater: const UnitConversionInfo(0.000335, 'ftH2O'),
    MeasureUnitsEnum.CentimetreMercury: const UnitConversionInfo(0.00075, 'cmHg'),
    MeasureUnitsEnum.InchesMercury: const UnitConversionInfo(0.000295, 'inHg'),
    MeasureUnitsEnum.InchesWater: const UnitConversionInfo(0.004014, 'inH2O'),
    MeasureUnitsEnum.Pascal: const UnitConversionInfo(1, 'Pa'),
  }),
  MeasuresEnum.DynamicViscosity:
      MeasureInfo(MeasuresEnum.DynamicViscosity, MeasureUnitsEnum.Centipoise, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Centipoise: const UnitConversionInfo(1, 'cp'),
    MeasureUnitsEnum.MillipascalSecond: const UnitConversionInfo(1, 'mPa·s'),
    MeasureUnitsEnum.Poise: const UnitConversionInfo.full(100, 'P', OperatorEnum.Divide),
    MeasureUnitsEnum.PascalSecond: const UnitConversionInfo.full(1000, 'Pa·s', OperatorEnum.Divide),
    MeasureUnitsEnum.Pound_FootSecond: const UnitConversionInfo(0.000672, 'lb/(ft·s)'),
  }),
  MeasuresEnum.KinematicViscosity:
      MeasureInfo(MeasuresEnum.KinematicViscosity, MeasureUnitsEnum.Centistoke, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Centistoke: const UnitConversionInfo(1, 'cs'),
    MeasureUnitsEnum.Stoke: const UnitConversionInfo.full(100, 'St', OperatorEnum.Divide),
    MeasureUnitsEnum.FootSquaref_Second: const UnitConversionInfo(0.000011, 'ft2/s'),
    MeasureUnitsEnum.MetreSquare_Second: const UnitConversionInfo(0.000001, 'm2/s'),
  }),
  MeasuresEnum.Torque:
      MeasureInfo(MeasuresEnum.Torque, MeasureUnitsEnum.NewtonMetre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.NewtonMillimetre: const UnitConversionInfo(1000, 'Nmm'),
    MeasureUnitsEnum.NewtonCentimetre: const UnitConversionInfo(100, 'Ncm'),
    MeasureUnitsEnum.NewtonMetre: const UnitConversionInfo(1, 'Nm'),
    MeasureUnitsEnum.KilogramForceMetre: const UnitConversionInfo(0.101972, 'kgfm'),
    MeasureUnitsEnum.FootPound: const UnitConversionInfo(0.737561, 'ftlb'),
    MeasureUnitsEnum.InchPound: const UnitConversionInfo(8.850732, 'inlb'),
  }),
  MeasuresEnum.Density:
      MeasureInfo(MeasuresEnum.Density, MeasureUnitsEnum.Kilogram_MetreCube, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Gramm_MetreCube: const UnitConversionInfo(1000, 'gr/m3'),
    MeasureUnitsEnum.Kilogram_MetreCube: const UnitConversionInfo(1, 'kg/m3'),
    MeasureUnitsEnum.Gramm_CentimetreCube: const UnitConversionInfo.full(1000, 'gr/cm3', OperatorEnum.Divide),
    MeasureUnitsEnum.Gram_Milliliter: const UnitConversionInfo.full(1000, 'g/ml', OperatorEnum.Divide),
    MeasureUnitsEnum.Pound_FootCube: const UnitConversionInfo(0.062422, 'lb/ft3'),
    MeasureUnitsEnum.Pound_InchCube: const UnitConversionInfo(0.000036, 'lb/in3'),
  }),
  MeasuresEnum.Inertia:
      MeasureInfo(MeasuresEnum.Inertia, MeasureUnitsEnum.KilogramSquareMetre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.KilogramSquareMetre: const UnitConversionInfo(1, 'kg·m2'),
    MeasureUnitsEnum.PoundSquareFoot: const UnitConversionInfo.full(4.882, 'lbf·ft·s2', OperatorEnum.Divide),
  }),

  //// Computer units
  MeasuresEnum.DataSize:
      MeasureInfo(MeasuresEnum.DataSize, MeasureUnitsEnum.Megabyte, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Bit: UnitConversionInfo.delegate('', BitConverter()),
    MeasureUnitsEnum.Byte: UnitConversionInfo.delegate('B', ByteConverter()),
    MeasureUnitsEnum.Kilobyte: const UnitConversionInfo(1024, 'KB'),
    MeasureUnitsEnum.Megabyte: const UnitConversionInfo(1, 'MB'),
    MeasureUnitsEnum.Gigabyte: UnitConversionInfo.delegate('GB', GigabyteConverter()),
    MeasureUnitsEnum.Terabyte: UnitConversionInfo.delegate('TB', TerabyteConverter()),
    MeasureUnitsEnum.Petabyte: UnitConversionInfo.delegate('PB', PetabyteConverter()),
  }),
  MeasuresEnum.DataTransferRate: MeasureInfo(
      MeasuresEnum.DataTransferRate, MeasureUnitsEnum.MegabitsPerSecond, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.BitsPerSecond: const UnitConversionInfo(1000000, 'bps'),
    MeasureUnitsEnum.BytesPerSecond: const UnitConversionInfo(125000, 'Bps'),
    MeasureUnitsEnum.KilobitsPerSecond: const UnitConversionInfo(1000, 'Kbps'),
    MeasureUnitsEnum.KilobytesPerSecond: const UnitConversionInfo(125, 'KBps'),
    MeasureUnitsEnum.MegabitsPerSecond: const UnitConversionInfo(1, 'Mbps'),
    MeasureUnitsEnum.MegabytesPerSecond: const UnitConversionInfo(0.125, 'MBps'),
    MeasureUnitsEnum.GigabitsPerSecond: const UnitConversionInfo(0.001, 'Gbps'),
    MeasureUnitsEnum.GigabytesPerSecond: const UnitConversionInfo(0.000125, 'GBps'),
  }),
  MeasuresEnum.ImageResolution: MeasureInfo(
      MeasuresEnum.ImageResolution, MeasureUnitsEnum.DotPerMillimetre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.DotPerMillimetre: const UnitConversionInfo(1, 'dot_mm'),
    MeasureUnitsEnum.DotPerInch: const UnitConversionInfo(25.4, 'dot_inch'),
    MeasureUnitsEnum.PixelPerCentimetre: const UnitConversionInfo(10, 'pixel_centimetre'),
    MeasureUnitsEnum.PixelPerInch: const UnitConversionInfo(25.4, 'pixel_inch'),
    MeasureUnitsEnum.DotPerMetre: const UnitConversionInfo(1000, 'dot_m'),
  }),

  //// Electricity and Magnetism
  MeasuresEnum.MagneticField:
      MeasureInfo(MeasuresEnum.MagneticField, MeasureUnitsEnum.Orsted, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Orsted: const UnitConversionInfo(1, 'Oe'),
    MeasureUnitsEnum.Amper_metre: UnitConversionInfo.delegate('A/m', AmperPerMeterConverter())
  }),
  MeasuresEnum.MagneticFlux:
      MeasureInfo(MeasuresEnum.MagneticFlux, MeasureUnitsEnum.Weber, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Maxwell: UnitConversionInfo.delegate('Mx', MaxwellConverter()),
    MeasureUnitsEnum.Nanoweber: UnitConversionInfo.delegate('nWb', NanoweberConverter()),
    MeasureUnitsEnum.Weber: const UnitConversionInfo(1, 'wb')
  }),
  MeasuresEnum.MagneticDensity:
      MeasureInfo(MeasuresEnum.MagneticDensity, MeasureUnitsEnum.Tesla, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Gamma: UnitConversionInfo.delegate('γ', GammaConverter()),
    MeasureUnitsEnum.Gauss: UnitConversionInfo.delegate('G', GaussConverter()),
    MeasureUnitsEnum.Tesla: const UnitConversionInfo(1, 'T')
  }),
  MeasuresEnum.ElectricCharge:
      MeasureInfo(MeasuresEnum.ElectricCharge, MeasureUnitsEnum.Coulomb, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Coulomb: const UnitConversionInfo(1, 'C'),
    MeasureUnitsEnum.MilliampereHour: const UnitConversionInfo(3.6, 'mA⋅h'),
    MeasureUnitsEnum.AmpereHour: const UnitConversionInfo(3600, 'A⋅h')
  }),
  MeasuresEnum.Resistivity:
      MeasureInfo(MeasuresEnum.Resistivity, MeasureUnitsEnum.OhmMetre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.CircularMil: const UnitConversionInfo(1, '601530493.4'),
    MeasureUnitsEnum.NanoohmMetre: const UnitConversionInfo(100, 'nΩ·cm'),
    MeasureUnitsEnum.OhmMetre: const UnitConversionInfo(1, 'Ω⋅m')
  }),
  MeasuresEnum.Conductivity:
      MeasureInfo(MeasuresEnum.Conductivity, MeasureUnitsEnum.SiemensPerMetre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.SiemensPerMetre: const UnitConversionInfo(1, 'S/m'),
    MeasureUnitsEnum.MhoPerCentimetre: const UnitConversionInfo.full(100, 'mho/cm', OperatorEnum.Divide)
  }),

  //// Light
  MeasuresEnum.Wavelength:
      MeasureInfo(MeasuresEnum.Wavelength, MeasureUnitsEnum.Mircometre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Angstrom: const UnitConversionInfo(10000, 'A'),
    MeasureUnitsEnum.Nanometre: const UnitConversionInfo(1000, 'nm'),
    MeasureUnitsEnum.Mircometre: const UnitConversionInfo(1, 'μm'),
    MeasureUnitsEnum.Centimetre: const UnitConversionInfo.full(10000, 'cm', OperatorEnum.Divide),
    MeasureUnitsEnum.Meter: UnitConversionInfo.delegate('m', WavelengthMeterConverter()),
  }),
  MeasuresEnum.Luminance:
      MeasureInfo(MeasuresEnum.Luminance, MeasureUnitsEnum.Candela_SquareMetre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Lambert: const UnitConversionInfo.full(10000, 'L', OperatorEnum.Divide),
    MeasureUnitsEnum.Candela_SquareInch: const UnitConversionInfo(0.00064516, 'cd/in'),
    MeasureUnitsEnum.Footlambert: const UnitConversionInfo(3.426, 'fL'),
    MeasureUnitsEnum.Candela_SquareMetre: const UnitConversionInfo(1, 'cd/m2'),
  }),
  MeasuresEnum.Illuminance:
      MeasureInfo(MeasuresEnum.Illuminance, MeasureUnitsEnum.Lux, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.CentimetreCandle: const UnitConversionInfo.full(10000, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Flame: const UnitConversionInfo(0.0232, ''),
    MeasureUnitsEnum.Footcandle: const UnitConversionInfo(0.0929, 'fc'),
    MeasureUnitsEnum.Lumen_SquareCentimetre: const UnitConversionInfo.full(10000, 'lm/cm2', OperatorEnum.Divide),
    MeasureUnitsEnum.Lumen_SquareFoot: const UnitConversionInfo(0.0929, 'lm/m2'),
    MeasureUnitsEnum.Lumen_SquareMetre: const UnitConversionInfo(1, ''),
    MeasureUnitsEnum.Lux: const UnitConversionInfo(1, 'lx'),
    MeasureUnitsEnum.MetreCandle: const UnitConversionInfo(1, ''),
    MeasureUnitsEnum.Nox: const UnitConversionInfo(1000, 'nx'),
  }),

  //// Radiation
  MeasuresEnum.Activity:
      MeasureInfo(MeasuresEnum.Activity, MeasureUnitsEnum.Rutherford, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Curie: const UnitConversionInfo(10000, 'Ci'),
    MeasureUnitsEnum.Becquerel: UnitConversionInfo.delegate('Bq', RadiationConverter()),
    MeasureUnitsEnum.Rutherford: const UnitConversionInfo(1, 'Rd'),
  }),
  MeasuresEnum.AbsorbedDose:
      MeasureInfo(MeasuresEnum.AbsorbedDose, MeasureUnitsEnum.Gray, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.ErgPerGram: const UnitConversionInfo.full(10000, 'erg/g', OperatorEnum.Divide),
    MeasureUnitsEnum.Rad: const UnitConversionInfo.full(100, 'rd', OperatorEnum.Divide),
    MeasureUnitsEnum.Gray: const UnitConversionInfo(1, 'Gy'),
    MeasureUnitsEnum.Centigray: const UnitConversionInfo(100, 'cGy'),
  }),
  MeasuresEnum.DoseEquivalent:
      MeasureInfo(MeasuresEnum.DoseEquivalent, MeasureUnitsEnum.Sievert, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.RoentgenEquivalent: const UnitConversionInfo(100, 'Rem'),
    MeasureUnitsEnum.BananaEquivalent: UnitConversionInfo.delegate('Bed', BananaConverter()),
    MeasureUnitsEnum.Millirem: const UnitConversionInfo(100000, 'mRem'),
    MeasureUnitsEnum.Sievert: const UnitConversionInfo(1, 'Sv'),
    MeasureUnitsEnum.Millisievert: const UnitConversionInfo(1000, 'mSv'),
    MeasureUnitsEnum.Microsievert: UnitConversionInfo.delegate('µSv', RadiationConverter()),
  }),
  MeasuresEnum.Exposure:
      MeasureInfo(MeasuresEnum.Exposure, MeasureUnitsEnum.Roentgen, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Roentgen: const UnitConversionInfo(1, 'R'),
    MeasureUnitsEnum.Coulomb_kilogram: const UnitConversionInfo(0.000258, 'C/kg'),
  }),

  //// Astronomical
  MeasuresEnum.AstroMass:
      MeasureInfo(MeasuresEnum.AstroMass, MeasureUnitsEnum.SolarMass, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.SolarMass: const UnitConversionInfo(1, 'M☉'),
    MeasureUnitsEnum.JupiterMasses: const UnitConversionInfo(1048, 'MJUP'),
    MeasureUnitsEnum.EarthMasses: const UnitConversionInfo(332950, 'M⊕')
  }),
  MeasuresEnum.AstroLength:
      MeasureInfo(MeasuresEnum.AstroLength, MeasureUnitsEnum.Parsecs, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.LunarDistance: const UnitConversionInfo(80290000, 'LD'),
    MeasureUnitsEnum.AstronomicalUnits: const UnitConversionInfo(206265, 'AU'),
    MeasureUnitsEnum.Gigametres: const UnitConversionInfo(30860000, 'Gm'),
    MeasureUnitsEnum.Parsecs: const UnitConversionInfo(1, 'pc'),
    MeasureUnitsEnum.LightYears: const UnitConversionInfo(3.262, 'ly'),
    MeasureUnitsEnum.Kiloparsecs: const UnitConversionInfo.full(1000, 'kpc', OperatorEnum.Divide),
    MeasureUnitsEnum.Megaparsecs: UnitConversionInfo.delegate('Mpc', WavelengthMeterConverter())
  }),

  //// Chemistry
  MeasuresEnum.MolarVolume:
      MeasureInfo(MeasuresEnum.MolarVolume, MeasureUnitsEnum.CubicMetres_mole, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Litre_mole: const UnitConversionInfo(1000, 'L/mol'),
    MeasureUnitsEnum.CubicDecimetres_mole: const UnitConversionInfo(1000, 'dm3/mol'),
    MeasureUnitsEnum.CubicCentimetres_mole: const UnitConversionInfo(100, 'cm3/mol'),
    MeasureUnitsEnum.CubicMetres_mole: const UnitConversionInfo(1, 'm3/mol'),
    MeasureUnitsEnum.Molar: const UnitConversionInfo.full(1000, 'M', OperatorEnum.Divide),
  }),
  MeasuresEnum.MolarMass:
      MeasureInfo(MeasuresEnum.MolarMass, MeasureUnitsEnum.Kilogram_mole, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Kilogram_mole: const UnitConversionInfo(1, 'kg/mol'),
    MeasureUnitsEnum.Gram_mole: const UnitConversionInfo.full(1000, 'g/mol', OperatorEnum.Divide),
    MeasureUnitsEnum.Pound_mole: const UnitConversionInfo(2.205, 'lb/mol'),
  }),
  MeasuresEnum.MassConcentration:
      MeasureInfo(MeasuresEnum.MassConcentration, MeasureUnitsEnum.Gram_litre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Milligram_litre: const UnitConversionInfo(1000, 'mg/L'),
    MeasureUnitsEnum.Gram_litre: const UnitConversionInfo(1, 'g/L'),
    MeasureUnitsEnum.Gram_100milliliters: const UnitConversionInfo.full(10, 'g/(100 mL)', OperatorEnum.Divide),
  }),
  MeasuresEnum.HardWater:
      MeasureInfo(MeasuresEnum.HardWater, MeasureUnitsEnum.Parts_million, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Micromolle_litre: const UnitConversionInfo.full(100.1, 'mmol/L', OperatorEnum.Divide),
    MeasureUnitsEnum.Parts_million: const UnitConversionInfo(1, 'ppm'),
    MeasureUnitsEnum.DegreeHardness: const UnitConversionInfo(0.02, 'dH'),
    MeasureUnitsEnum.DegreeGeneralHardness: const UnitConversionInfo.full(17.85, 'dGH', OperatorEnum.Divide),
    MeasureUnitsEnum.Grains_gallon: const UnitConversionInfo.full(17.17, 'gpg', OperatorEnum.Divide),
    MeasureUnitsEnum.EnglishDegrees: const UnitConversionInfo.full(14.25, '°Clark', OperatorEnum.Divide),
    MeasureUnitsEnum.FrenchDegrees: const UnitConversionInfo.full(10, '°fH', OperatorEnum.Divide),
  }),

  //// Obsolete Russian
  MeasuresEnum.DistanceOr:
      MeasureInfo(MeasuresEnum.DistanceOr, MeasureUnitsEnum.Arshin, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Vershok: const UnitConversionInfo.full(16, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Ladon: const UnitConversionInfo.full(9.4826, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Pyad: const UnitConversionInfo.full(4, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Fut: const UnitConversionInfo(0.42857142857, ''),
    MeasureUnitsEnum.Lokot: const UnitConversionInfo.full(1.5804, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Arshin: const UnitConversionInfo(1, ''),
    MeasureUnitsEnum.Sazhen: const UnitConversionInfo(3, ''),
    MeasureUnitsEnum.Versta: const UnitConversionInfo(1500, ''),
    MeasureUnitsEnum.Centimetre: const UnitConversionInfo(7112, 'cm'),
    MeasureUnitsEnum.Meter: const UnitConversionInfo(0.7112, 'm'),
    MeasureUnitsEnum.Kilometre: const UnitConversionInfo(0.00071, 'km')
  }),
  MeasuresEnum.MassOr: MeasureInfo(MeasuresEnum.MassOr, MeasureUnitsEnum.Funt, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Dolya: const UnitConversionInfo.full(9216, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Zolotnik: const UnitConversionInfo.full(96, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Lot: const UnitConversionInfo.full(32, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Funt: const UnitConversionInfo(1, ''),
    MeasureUnitsEnum.Pood: const UnitConversionInfo(40, ''),
    MeasureUnitsEnum.Berkovets: const UnitConversionInfo(400, ''),
    MeasureUnitsEnum.Milligram: const UnitConversionInfo(409517, 'mg'),
    MeasureUnitsEnum.Gram: const UnitConversionInfo(410, 'g'),
    MeasureUnitsEnum.Kilogram: const UnitConversionInfo.full(2.442, 'kg', OperatorEnum.Divide),
  }),
  MeasuresEnum.DryVolumeOr:
      MeasureInfo(MeasuresEnum.DryVolumeOr, MeasureUnitsEnum.Garnec, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Chast: const UnitConversionInfo.full(30, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Kruzhka: const UnitConversionInfo(0.4, ''),
    MeasureUnitsEnum.Garnec: const UnitConversionInfo(1, ''),
    MeasureUnitsEnum.Vedro: const UnitConversionInfo(4, ''),
    MeasureUnitsEnum.Chetverik: const UnitConversionInfo(8, ''),
    MeasureUnitsEnum.Osmina: const UnitConversionInfo(32, ''),
    MeasureUnitsEnum.Chetvert: const UnitConversionInfo(64, ''),
    MeasureUnitsEnum.Milliliter: const UnitConversionInfo(3279.842, 'mL'),
    MeasureUnitsEnum.Litre: const UnitConversionInfo(3.279842, 'L'),
  }),
  MeasuresEnum.LiquidVolumeOr:
      MeasureInfo(MeasuresEnum.LiquidVolumeOr, MeasureUnitsEnum.Vedro, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Shkalik: const UnitConversionInfo.full(200, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Charka: const UnitConversionInfo.full(100, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Butylka: const UnitConversionInfo.full(20, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Shtof: const UnitConversionInfo.full(10, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Chetvert: const UnitConversionInfo.full(8, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Vedro: const UnitConversionInfo.full(1, '', OperatorEnum.Divide),
    MeasureUnitsEnum.Bochka: const UnitConversionInfo(40, ''),
    MeasureUnitsEnum.Milliliter: const UnitConversionInfo(12299.41, 'mL'),
    MeasureUnitsEnum.Litre: const UnitConversionInfo(12.29941, 'L'),
  }),

  //// HeatFlowrate
  MeasuresEnum.ThermalConductivity: MeasureInfo(
      MeasuresEnum.ThermalConductivity, MeasureUnitsEnum.Watt_MetreKelvin, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Watt_MetreKelvin: const UnitConversionInfo(1, 'W/(m⋅K)'),
    MeasureUnitsEnum.BTU_per_hftFarengeit: const UnitConversionInfo(0.1762280394, ''),
  }),
  MeasuresEnum.HeatCapacity: MeasureInfo(
      MeasuresEnum.HeatCapacity, MeasureUnitsEnum.Joule_kelvin_kilogram, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.BTU_Fahrenheit: const UnitConversionInfo.full(4177.6, 'BTU/°F/lb', OperatorEnum.Divide),
    MeasureUnitsEnum.Kilojoule_kelvin_kilogram: const UnitConversionInfo.full(1000, 'kJ/°K/kg', OperatorEnum.Divide),
    MeasureUnitsEnum.Joule_Celsius_kilogram: const UnitConversionInfo.full(1000, 'J/°C/kg', OperatorEnum.Divide),
    MeasureUnitsEnum.Joule_kelvin_kilogram: const UnitConversionInfo(1, 'J/°K/kg'),
    MeasureUnitsEnum.SmallCalorie: const UnitConversionInfo(4.184, 'cal/°C'),
    MeasureUnitsEnum.LargeCalorie: const UnitConversionInfo(4184, 'kcal/°C'),
  }),
  MeasuresEnum.HeatOfCombustionMass: MeasureInfo(
      MeasuresEnum.HeatOfCombustionMass, MeasureUnitsEnum.MegaJoule_CubicMetre, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Joule_CubicMetre: const UnitConversionInfo.full(1000, 'J/m3', OperatorEnum.Divide),
    MeasureUnitsEnum.MegaJoule_CubicMetre: const UnitConversionInfo(1, 'mJ/m3'),
    MeasureUnitsEnum.BTU_CubicFoot: const UnitConversionInfo(26.84, 'Btu/ft3'),
  }),
  MeasuresEnum.HeatOfCombustionVolume: MeasureInfo(
      MeasuresEnum.HeatOfCombustionVolume, MeasureUnitsEnum.MegaJoule_Kilogram, <MeasureUnitsEnum, UnitConversionInfo>{
    MeasureUnitsEnum.Joule_Kilogram: const UnitConversionInfo.full(1000, 'J/kg', OperatorEnum.Divide),
    MeasureUnitsEnum.MegaJoule_Kilogram: const UnitConversionInfo(1, 'mJ/kg'),
    MeasureUnitsEnum.BTU_Pound: const UnitConversionInfo(430, 'BTU/lb'),
    MeasureUnitsEnum.KiloCalories_Kilogram: const UnitConversionInfo(238.8, 'kcal/kg'),
  }),
};
