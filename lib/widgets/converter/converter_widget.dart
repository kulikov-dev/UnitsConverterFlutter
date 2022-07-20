import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unit/constants/colors.dart';
import 'package:unit/constants/enums.dart';
import 'package:unit/data/measure.dart';
import 'package:unit/routes.dart';
import 'package:unit/unit_converter_app.dart';
import 'package:unit/utils/app_localization.dart';
import 'package:unit/utils/device_utils.dart';
import 'package:unit/utils/measure_converter.dart';
import 'package:unit/utils/type_helpers.dart';
import 'package:unit/widgets/converter/text_units_widget.dart';

/// Widget of conversion between units
class ConverterWidget extends StatefulWidget {
  @override
  _ConverterWidgetState createState() => _ConverterWidgetState();
}

/// State of widget
class _ConverterWidgetState extends State<ConverterWidget> {
  /// From search text controller
  final TextEditingController _fromSearchController = TextEditingController();

  /// To search text controller
  final TextEditingController _toSearchController = TextEditingController();

  final ScrollController _fromScrollController = ScrollController();

  final ScrollController _toScrollController = ScrollController();

  /// Info about current measure
  MeasureInfo measureInfo;

  /// Flag if favorite state is changed
  bool _isFavoriteChanged = false;

  /// Initialize state of widget
  @override
  void initState() {
    super.initState();

    _fromSearchController.addListener(() {
      setState(() {});
    });

    _toSearchController.addListener(() {
      setState(() {});
    });
  }

  /// Finalization
  @override
  void dispose() {
    _fromScrollController?.dispose();
    _toScrollController?.dispose();
    _fromSearchController?.dispose();
    _toSearchController?.dispose();
    super.dispose();
  }

  /// Build widget
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations locale = AppLocalizations.of(context);

    final bool isSmallSize= MediaQuery.of(context).size.width <= 380;
    final double iconSize = !isSmallSize ? 26 : 23;
    const int bigAmountOfMeasures = 8;
    final TextStyle smallStyle = theme.textTheme.bodyText1.copyWith(
      fontSize: DeviceUtils.getScaledText(context, 15),
    );

    final TextStyle extraSmallStyle = theme.textTheme.bodyText1.copyWith(
      fontSize: DeviceUtils.getScaledText(context, 12),
    );

    final MeasuresEnum measure = (ModalRoute.of(context).settings.arguments as MeasureArguments).measure;
    measureInfo = measuresInfo[measure];
    final bool isScrollable = measureInfo.measureUnits.length > bigAmountOfMeasures;
    final String fromText = locale.translate('From');
    final String toText = locale.translate('To');

    String title = locale.translate(TypeHelpers.getEnumCaption(measure));
    if (measure == MeasuresEnum.MedicineVolume) {
      title = title + ' *';
    }

    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            iconTheme: theme.iconTheme,
            title: FittedBox(child: Text(title, style: theme.textTheme.caption)),
            brightness: UnitConverterApp.isDarkMode ? Brightness.dark : Brightness.light,
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        measureInfo.isFavorite = !measureInfo.isFavorite;
                        _isFavoriteChanged = true;
                      });
                    },
                    child: Icon(
                      measureInfo.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: theme.iconTheme.color,
                      size: iconSize,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.settings).then((Object value) {
                        if (value) {
                          setState(() {});
                        }
                      });
                    },
                    child: Icon(
                      Icons.settings,
                      color: theme.iconTheme.color,
                      size: iconSize,
                    ),
                  )),
            ]),
        resizeToAvoidBottomInset: false,
        body: Builder(builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                Navigator.pop(context, _isFavoriteChanged);
                return false;
              },
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    // Sensitivity
                    if (details.delta.dx > 10) {
                      Navigator.pop(context, _isFavoriteChanged);
                    }
                  },
                  child: Column(children: <Widget>[
                    Container(
                        color: theme.primaryColor,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          TextUnitsWidget(measureInfo, _onUnitsSwitched),
                          Visibility(
                              visible: measure == MeasuresEnum.MedicineVolume,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 7),
                                  child: Container(
                                      alignment: Alignment.centerRight, child: Text(locale.translate('Approximated'), style: extraSmallStyle)))),
                          const Divider(
                            height: 1,
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 4),
                              child: Column(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 4), child: Text(locale.translate('MeasureUnits'), style: smallStyle)),
                                Row(children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 7, 0), child: Text(fromText + ':', style: smallStyle)),
                                        Visibility(
                                            visible: isScrollable,
                                            child: Expanded(child: _getSearchEditor(locale, theme, smallStyle, _fromSearchController)))
                                      ])),
                                  const VerticalDivider(
                                    thickness: 4,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(1, 0, 10, 0),
                                            child: Text(
                                              toText + ':',
                                              style: smallStyle,
                                            )),
                                        Visibility(
                                            visible: isScrollable,
                                            child: Expanded(
                                                child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                    child: _getSearchEditor(locale, theme, smallStyle, _toSearchController))))
                                      ]))
                                ])
                              ]))
                        ])),
                    Expanded(
                        child: Row(children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Scrollbar(
                              thickness: 3,
                              isAlwaysShown: isScrollable,
                              controller: _fromScrollController,
                              child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: UnitConverterApp.isDarkMode ? AppColors.primaryDarkColor : AppColors.primaryLightColor, width: 3)),
                                  child: ListView(
                                      controller: _fromScrollController,
                                      physics: const BouncingScrollPhysics(),
                                      children: _getUnitsRadioButtons(theme, locale, measureInfo, true))))),
                      Flexible(
                          flex: 1,
                          child: Scrollbar(
                              thickness: 3,
                              isAlwaysShown: isScrollable,
                              controller: _toScrollController,
                              child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: UnitConverterApp.isDarkMode ? AppColors.primaryDarkColor : AppColors.primaryLightColor, width: 3)),
                                  child: ListView(
                                      controller: _toScrollController,
                                      physics: const BouncingScrollPhysics(),
                                      children: _getUnitsRadioButtons(theme, locale, measureInfo, false)))))
                    ]))
                  ])));
        }));
  }

  /// Get search editors
  Widget _getSearchEditor(AppLocalizations locale, ThemeData theme, TextStyle smallStyle, TextEditingController controller) {
    return TextField(
        controller: controller,
        style: smallStyle,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 25,
            minWidth: 25,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              controller.clear();
            },
            child: const Icon(Icons.clear),
          ),
          hintText: locale.translate('Search'),
          fillColor: theme.backgroundColor,
          contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(2.0),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor),
          ),
        ));
  }

  /// Get list of radio buttons of measure units
  List<Widget> _getUnitsRadioButtons(ThemeData theme, AppLocalizations locale, MeasureInfo measureInfo, bool isFrom) {
    final List<Widget> result = <Widget>[];
    final String searchCondition = isFrom ? _fromSearchController.text : _toSearchController.text;
    final String postfix = isFrom ? '' : '';
    for (MeasureUnitsEnum unit in measureInfo.measureUnits.keys) {
      String unitCaption;
      final UnitConversionInfo unitInfo = measureInfo.measureUnits[unit];
      if (UnitConverterApp.settings.unitFormat == UnitsFormatEnum.Full || unitInfo.symbol == null || unitInfo.symbol == ''){
        unitCaption = locale.translate(TypeHelpers.getEnumCaption(unit) + postfix);
      } else {
        unitCaption = locale.translate(TypeHelpers.getEnumCaption(unitInfo.symbol));
      }

      if (searchCondition.isNotEmpty && !TypeHelpers.containsIgnoreCase(unitCaption, searchCondition)) {
        continue;
      }

      final GestureDetector child = GestureDetector(
        onTap: () {
          _updateLastUsedMeasureUnit(unit, isFrom);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,5,0),
          child: Row(
          children: <Widget>[
            Radio<MeasureUnitsEnum>(
                value: unit,
                groupValue: isFrom ? measureInfo.lastFromMeasureUnit : measureInfo.lastToMeasureUnit,
                activeColor: theme.accentColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (MeasureUnitsEnum value) {
                  _updateLastUsedMeasureUnit(value, isFrom);
                }),
            Expanded(
                child: Text(
              unitCaption,
              softWrap: true,
            ))
          ],
        ),
        ));

      result.add(child);
    }

    return result;
  }

  /// Update last used measure unit
  void _updateLastUsedMeasureUnit(MeasureUnitsEnum value, bool isFrom) {
    setState(() {
      if (isFrom) {
        measureInfo.lastFromMeasureUnit = value;
      } else {
        measureInfo.lastToMeasureUnit = value;
      }
    });
  }

  /// Event on units switched
  void _onUnitsSwitched() {
    setState(() {});
  }
}
