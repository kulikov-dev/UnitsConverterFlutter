import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';
import 'package:unit/constants/colors.dart';
import 'package:unit/constants/enums.dart';
import 'package:unit/data/measure.dart';
import 'package:unit/routes.dart';
import 'package:unit/unit_converter_app.dart';
import 'package:unit/utils/app_localization.dart';
import 'package:unit/utils/device_utils.dart';
import 'package:unit/utils/type_helpers.dart';
import 'package:unit/widgets/main/measure_widget.dart';

// 5. Протестировать значения перевода
// 6. Подготовить сборку к выкладыванию, усложнение кода
// 7. Подготовить тексты, иконки скриншоты
// 8. Выложить.

//4. Калькуляторы. Перевод силы света.
// 5. Два вида просмотра: текущий и табличный (возможно после релиза)

/// Widget for measures viewing
class MainPage extends StatefulWidget {
  /// Constructor
  MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

/// State for widget for measures viewing
class _MainPageState extends State<MainPage> {
  /// Text controller
  final TextEditingController _fromController = TextEditingController();

  /// Current locale info
  Locale currentLocale;

  bool isCurrentDark;

  final ScrollController _scrollController = ScrollController();

  /// List of categories widgets
  List<Widget> categoriesWidgets;

  /// Constructor
  @override
  void initState() {
    super.initState();

    _fromController.addListener(() {
      UnitConverterApp.needUpdateWidgets = true;
      setState(() {});
    });
  }

  /// Destructor
  @override
  void dispose() {
    _fromController?.dispose();
    super.dispose();
  }

  /// Widget building
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations locale = AppLocalizations.of(context);
    final bool isSmallSize = MediaQuery.of(context).size.width <= 380;
    final double textScaleFactor = !isSmallSize ? 16 : 14;
    final double captionScaleFactor = !isSmallSize ? 20 : 17;
    final double iconSize = !isSmallSize ? 26 : 23;
    final TextStyle style = theme.textTheme.bodyText2.copyWith(
      fontSize: DeviceUtils.getScaledText(context, textScaleFactor),
    );
    final TextStyle captionStyle = theme.textTheme.caption.copyWith(
      fontSize: DeviceUtils.getScaledText(context, captionScaleFactor),
    );

    if (UnitConverterApp.needUpdateWidgets || currentLocale != locale.locale) {
      _getCategoriesWidgets( locale);
      UnitConverterApp.needUpdateWidgets = false;
    }
    currentLocale = locale.locale;
    final Color primaryColor = UnitConverterApp.isDarkMode ? AppColors.primaryDarkColor : AppColors.primaryLightColor;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(locale.translate('AppTitle'), style: captionStyle),
          brightness: UnitConverterApp.isDarkMode ? Brightness.dark : Brightness.light,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () {
                    LaunchReview.launch();
                  },
                  child: Icon(
                    Icons.star,
                    color: theme.iconTheme.color,
                    size: iconSize,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.settings);
                  },
                  child: Icon(
                    Icons.settings,
                    color: theme.iconTheme.color,
                    size: iconSize,
                  ),
                )),
          ],
        ),
        body:  Builder(
        builder: (BuildContext context) => GestureDetector(
            onTap: () {
              DeviceUtils.hideKeyboard(context);
            },
            child: Column(children: <Widget>[
              Container(
                color: theme.primaryColor,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: TextField(
                      controller: _fromController,
                      style: style,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(50),
                      ],
                      maxLengthEnforced: false,
                      decoration: InputDecoration(
                        hintText: locale.translate('Search'),
                        suffixIconConstraints: const BoxConstraints(
                          minHeight: 36,
                          minWidth: 36,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _fromController.clear();
                          },
                          child: const Icon(Icons.clear),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
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
                    )),
              ),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                //                   <--- left side
                                color: primaryColor,
                                width: 3.0,
                              ),
                              top: BorderSide(
                                //                    <--- top side
                                color: primaryColor,
                                width: 3.0,
                              ),
                              right: BorderSide(
                                //                    <--- top side
                                color: primaryColor,
                                width: 3.0,
                              ),
                              bottom: const BorderSide(
                                //                    <--- top side
                                color: AppColors.primaryDarkColor,
                                width: 3.0,
                              ))),
                      child: Scrollbar(
                          isAlwaysShown: true,
                          controller: _scrollController,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: ListView(controller: _scrollController, children: categoriesWidgets))))),
            ]))));
  }

  /// Event on favorite state of measure element changed
  void onChangeFavoriteState() {
    setState(() {
      UnitConverterApp.needUpdateWidgets = true;
    });
  }

  /// Get list of widgets for the category
  List<Widget> _getCategoriesWidgets(AppLocalizations locale) {
    categoriesWidgets = <Widget>[];
    final List<MeasuresEnum> favorites = <MeasuresEnum>[];
    int prevCount = categoriesWidgets.length;
    for (int i = 0; i < MeasureCategoriesEnum.values.length; ++i) {
      final MeasureCategoriesEnum category = MeasureCategoriesEnum.values[i];
      final List<MeasuresEnum> measures = categories[category];
      final String categoryCaption = locale.translate(TypeHelpers.getEnumCaption(category));
      final List<MeasuresEnum> subFavorites = _getMeasuresWidgetsForCategory(categoryCaption, measures, locale, false);
      if (i != MeasureCategoriesEnum.values.length - 1 && prevCount != categoriesWidgets.length) {
        categoriesWidgets.add(const Divider());
        prevCount = categoriesWidgets.length;
      }

      if (subFavorites.isNotEmpty) {
        favorites.addAll(subFavorites);
      }
    }

    if (favorites.isNotEmpty) {
      final String caption = locale.translate('Favorites');
      _getMeasuresWidgetsForCategory(caption, favorites, locale, true);
    }

    return categoriesWidgets;
  }

  /// Get list of measure elements for the category
  List<MeasuresEnum> _getMeasuresWidgetsForCategory(
      String categoryCaption, List<MeasuresEnum> measures, AppLocalizations locale, bool isForFavorite) {
    final ThemeData theme = Theme.of(context);
    final double textScaleFactor = MediaQuery.of(context).size.width > 380 ? 17 : 13;
    final TextStyle style = theme.textTheme.bodyText2.copyWith(
      fontSize: DeviceUtils.getScaledText(context, textScaleFactor),
      color: UnitConverterApp.isDarkMode ? Colors.white60 : Colors.black54
    );
    final List<Widget> result = <Widget>[];
    final List<MeasuresEnum> favorites = <MeasuresEnum>[];
    for (MeasuresEnum measure in measures) {
      final MeasureInfo info = measuresInfo[measure];

      if (!_filterBySearch(measure, info, locale)) {
        continue;
      }

      result.add(MeasureWidget(measure, onChangeFavoriteState));
      if (info.isFavorite) {
        favorites.add(measure);
      }
    }

    if (result.isNotEmpty) {

      final Padding categoryTitleWidget = Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 5), child: Text(categoryCaption, style: style));
      if (isForFavorite) {
        categoriesWidgets.insert(0, categoryTitleWidget);
        result.add(const Divider());
        categoriesWidgets.insertAll(1, result);
      } else {
        categoriesWidgets.add(categoryTitleWidget);
        categoriesWidgets.addAll(result);
      }
    }

    return favorites;
  }

  /// Check if measure satisfies search filter
  bool _filterBySearch(MeasuresEnum measure, MeasureInfo info, AppLocalizations locale) {
    final String searchCondition = _fromController.text;
    if (searchCondition.isNotEmpty) {
      final String unitCaption = locale.translate(TypeHelpers.getEnumCaption(measure));
      if (!TypeHelpers.containsIgnoreCase(unitCaption, searchCondition)) {
        for (MeasureUnitsEnum measure in info.measureUnits.keys) {
          final String measureCaption = locale.translate(TypeHelpers.getEnumCaption(measure));
          if (!TypeHelpers.containsIgnoreCase(measureCaption, searchCondition)) {
            continue;
          }

          return true;
        }

        return false;
      }
    }

    return true;
  }
}
