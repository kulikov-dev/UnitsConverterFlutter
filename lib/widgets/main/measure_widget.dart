import 'package:flutter/material.dart';
import 'package:unit/constants/enums.dart';
import 'package:unit/data/measure.dart';
import 'package:unit/routes.dart';
import 'package:unit/utils/app_localization.dart';
import 'package:unit/utils/device_utils.dart';
import 'package:unit/utils/type_helpers.dart';

/// Widget for one measure element
class MeasureWidget extends StatefulWidget {
  /// Constructor
  MeasureWidget(this.measure, this.onChangeFavoriteState);

  /// Measure element
  final MeasuresEnum measure;

  /// Function event for favorite state changed
  final Function() onChangeFavoriteState;

  @override
  _MeasureWidgetState createState() => _MeasureWidgetState();
}

/// State for widget for one measure element
class _MeasureWidgetState extends State<MeasureWidget> {
  /// Widget building
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations locale = AppLocalizations.of(context);
    final double textScaleFactor = MediaQuery.of(context).size.width > 380 ? 18 : 14;
    final TextStyle style = theme.textTheme.bodyText2.copyWith(
      fontSize: DeviceUtils.getScaledText(context, textScaleFactor),
    );

    final String caption = TypeHelpers.getEnumCaption(widget.measure);
    final MeasureInfo measureInfo = measuresInfo[widget.measure];

    return Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
        decoration: BoxDecoration(
          border: Border.all(color: theme.accentColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: ListTile(
          leading: Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 10), child: measureInfo.imageWidget),
          trailing: GestureDetector(
            onTap: () {
              measureInfo.isFavorite = !measureInfo.isFavorite;
              MeasureInfo.saveToJson(widget.measure);
              widget.onChangeFavoriteState();
            },
            child: Icon(
              measureInfo.isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 26.0,
            ),
          ),
          title: Transform.translate(
              offset: const Offset(-8, 0),
              child: Text(
                locale.translate(caption),
                style: style,
              )),
          onTap: () {
            Navigator.pushNamed(context, Routes.converter, arguments: MeasureArguments(widget.measure)).then((Object value) {
              DeviceUtils.hideKeyboard(context);
              MeasureInfo.saveToJson(widget.measure);
              DeviceUtils.isSnackBarActive = false;
              if (value) {
                widget.onChangeFavoriteState();
              }
            });
          },
        ));
  }
}