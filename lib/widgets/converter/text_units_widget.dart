import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unit/constants/colors.dart';
import 'package:unit/constants/enums.dart';
import 'package:unit/data/measure.dart';
import 'package:unit/unit_converter_app.dart';
import 'package:unit/utils/app_localization.dart';
import 'package:unit/utils/device_utils.dart';
import 'package:unit/utils/measure_converter.dart';
import 'package:unit/utils/type_helpers.dart';

/// Text widget with from-to measure panel
class TextUnitsWidget extends StatefulWidget {
  /// Constructor
  TextUnitsWidget(this.measureInfo, this.onUnitsSwitched);

  /// Measure information
  final MeasureInfo measureInfo;

  /// Event on units switched
  final Function() onUnitsSwitched;

  @override
  _TextUnitsWidgetState createState() => _TextUnitsWidgetState();
}

/// State for text widget
class _TextUnitsWidgetState extends State<TextUnitsWidget> {
  /// From unit text controller
  final TextEditingController _fromController = TextEditingController();

  /// To unit text controller
  final TextEditingController _toController = TextEditingController();

  /// Is first widget initialization
  bool isFirstInitialize = true;

  /// Initialize state of widget
  @override
  void initState() {
    super.initState();

    _fromController.addListener(() {
      setState(() {});
    });
  }

  /// Finalization
  @override
  void dispose() {
    _fromController?.dispose();
    _toController?.dispose();
    super.dispose();
  }

  /// Build widget
  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.of(context).size.width > 380 ? 16 : 14;
    final AppLocalizations locale = AppLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final TextStyle style = theme.textTheme.bodyText2.copyWith(
      fontSize: DeviceUtils.getScaledText(context, textScaleFactor),
    );

    if (isFirstInitialize) {
      if (widget.measureInfo.lastValue != null) {
        _fromController.text = widget.measureInfo.lastValue.toString();
      }

      isFirstInitialize = false;
    }

    final String fromText = locale.translate('From');
    final String toText = locale.translate('To');

    final String measureFrom = locale.translate(TypeHelpers.getEnumCaption(widget.measureInfo.lastFromMeasureUnit)).toLowerCase();
    final String measureTo = locale.translate(TypeHelpers.getEnumCaption(widget.measureInfo.lastToMeasureUnit)).toLowerCase();

    final StatelessWidget clearButton =
        _fromController.text.isEmpty ? Container() : IconButton(onPressed: () => _fromController.clear(), icon: const Icon(Icons.clear));

    final IconButton switchButton = _fromController.text.isEmpty
        ? IconButton(onPressed: () => _switchMeasureUnits(), icon: const Icon(Icons.shuffle))
        : IconButton(
            padding: EdgeInsets.zero, constraints: const BoxConstraints(), onPressed: () => _switchMeasureUnits(), icon: const Icon(Icons.shuffle));

    widget.measureInfo.lastValue = _fromController.text;
    final String newValueStr = MeasureConverter.convert(widget.measureInfo);
    if (widget.measureInfo.lastValue != 0 && newValueStr == '0')
      _toController.text = locale.translate('TooSmall');
    else
      _toController.text = newValueStr;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            fromText + ' ' + measureFrom + ':',
            style: style,
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextField(
            controller: _fromController,
            style: style,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(25),
            ],
            maxLengthEnforced: false,
            decoration: InputDecoration(
              suffixIcon:
                  Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[switchButton, clearButton]),
              suffixIconConstraints: const BoxConstraints(
                minHeight: 36,
                minWidth: 36,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
              filled: true,
              fillColor: theme.backgroundColor,
              isDense: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor),
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Text(
            toText + ' ' + measureTo + ':',
            style: style,
          )), // Only numbers can be entered
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: TextField(
            controller: _toController,
            style: style,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              suffixIconConstraints: const BoxConstraints(
                minHeight: 42,
                minWidth: 42,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  if (_toController.text != '') {
                    _copyToClipboard(context, locale);
                  }
                },
                child: const Icon(Icons.copy),
              ),
              contentPadding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
              filled: true,
              fillColor: theme.backgroundColor,
              isDense: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: UnitConverterApp.isDarkMode ? AppColors.accentDarkColor : AppColors.accentLightColor),
              ),
            ),
            readOnly: true,
          ))
    ]);
  }

  /// Copy to clipboard action
  void _copyToClipboard(BuildContext context, AppLocalizations locale) {
    Clipboard.setData(ClipboardData(text: _toController.text));
    DeviceUtils.showSnackbar(context, locale.translate('Copied'), null, false);
  }

  /// Switch measure units action
  void _switchMeasureUnits() {
    final MeasureUnitsEnum temp = widget.measureInfo.lastToMeasureUnit;
    widget.measureInfo.lastToMeasureUnit = widget.measureInfo.lastFromMeasureUnit;
    widget.measureInfo.lastFromMeasureUnit = temp;
    widget.onUnitsSwitched();
  }
}
