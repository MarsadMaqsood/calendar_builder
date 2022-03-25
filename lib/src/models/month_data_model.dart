import 'package:flutter/material.dart';

import 'package:calendar_builder/calendar_builder.dart';
import 'package:calendar_builder/src/utils/date_utils_cb.dart';

///Year Header Builder
typedef WidgetCbYearHeader = Widget Function(
  bool isYearPickerExpanded,
  DateTime selectedDate,
  DateTime selectedYear,
  String year,
);

///year button builder
typedef WidgetCbYearButton = Widget Function(
  DateTime dateTime,
  double heightResponsive,
  double widthResponsive,
  bool isYearDisabled,
  bool isYearSelected,
);

///Month button builder
typedef WidgetCbMonthButton = Widget Function(
    DateTime dateTime,
    double childHeight,
    double childWidth,
    bool isSelected,
    bool isDisabled,
    bool hasEvent,
    bool isHighlighted,
    bool isCurrentDate);

/// Month week builder
typedef WidgetCbMonthWeek = Widget Function(
  int index,
  String weeks,
  double weekHeight,
  double weekWidth,
);

///Month Header builder
typedef WeidgetCbMonthHeader = Widget Function(
  String month,
  double headerHeight,
  double headerWidth,
  double paddingLeft,
);

///A data class for customizing buttons of [CbYearDropDown]
class YearButtonCustomizer {
  ///constructor
  YearButtonCustomizer({
    this.borderColorOnSelected,
    this.borderColorOnDisabled,
    this.borderColorOnEnabled,
    this.textColorOnSelected,
    this.textColorOnDisabled,
    this.textColorOnEnabled,
    this.splashColor,
    this.hoverColor,
    this.onPressed,
    this.shrinkOnButtonPressed = true,
  });

  ///Apply border color to button When buttton is [selected]
  final Color? borderColorOnSelected;

  ///Apply border color to button When buttton is [Disabled]

  final Color? borderColorOnDisabled;

  ///Apply border color to button When buttton is [Enabled]

  final Color? borderColorOnEnabled;

  ///change text color of [selected] year inside Button
  final Color? textColorOnSelected;

  ///change text color of [Disabled] year inside Button

  final Color? textColorOnDisabled;

  ///change text color of [enabled] year inside Button

  final Color? textColorOnEnabled;

  ///Change spalash color of button
  final Color? splashColor;

  ///Change hover color of button

  final Color? hoverColor;

  ///onPress calback when buttton is pressed
  final void Function(bool isButtonDisabled, DateTime selectedYear)? onPressed;

  ///shrink expanded  On Buttton Pressed [bool]
  ///default [true]
  final bool shrinkOnButtonPressed;
}

///A data class for customizing year Header  of [CbYearDropDown]

class YearHeaderCustomizer {
  ///
  YearHeaderCustomizer({
    this.titleTextStyle,
    this.height = 40,
    this.width,
    this.downIcon = Icons.arrow_drop_down_outlined,
    this.upIcon = Icons.arrow_drop_up_outlined,
  });

  ///change TextStyle of year title
  final TextStyle? titleTextStyle;

  ///change height of year Headder
  final double height;

  ///change width of year Headder
  final double? width;

  ///change expanded down icons
  final IconData downIcon;

  ///change expanded up icons
  final IconData upIcon;
}

///Customize year DropDown
class YearDropDownCustomizer {
  ///
  const YearDropDownCustomizer({
    this.yearHeaderCustomizer,
    this.yearButtonCustomizer,
    this.yearHeaderBuilder,
    this.yearButtonBuilder,
    this.expandedYearHeight = 200,
    this.expandedYearWidth,
    this.expandYearInitially = false,
  });

  ///customise year Header style [YearHeaderCustomizer]
  ///```dart
  ///
  ///YearHeaderCustomizer(),
  ///
  ///
  /// ```
  /// {@end-tool}
  final YearHeaderCustomizer? yearHeaderCustomizer;

  ///customise year button style [YearButtonCustomizer]
  ///```dart
  ///
  ///YearButtonCustomizer(),
  ///
  ///
  /// ```
  /// {@end-tool}
  final YearButtonCustomizer? yearButtonCustomizer;

  ///Build your custom YearDropDown Header
  ///
  ///* NOTE: COPY & PASTE
  ///*### Sample code
  ///
  /// ```dart
  /// yearHeaderBuilder: (isYearPickerExpanded, selectedDate, selectedYear, year) {
  ///         return SizedBox(
  ///           height: 40,
  ///           child: Row(
  ///             mainAxisAlignment: MainAxisAlignment.center,
  ///             crossAxisAlignment: CrossAxisAlignment.center,
  ///             children: [
  ///               Text(
  ///                 year,
  ///                 style: const TextStyle(fontWeight: FontWeight.bold),
  ///               ),
  ///               Icon(!isYearPickerExpanded
  ///                   ? Icons.arrow_drop_down_outlined
  ///                   : Icons.arrow_drop_up_outlined)
  ///             ],
  ///           ),
  ///         );
  ///       },
  /// ```
  /// {@end-tool}
  ///
  final WidgetCbYearHeader? yearHeaderBuilder;

  ///Build your own year buttons
  ///
  ///* NOTE: COPY & PASTE
  ///*### Sample code
  ///
  /// ```dart
  /// yearButtonBuilder: (dateTime, heightResponsive,widthResponsive, isyearDisabled, isYearselected) {
  ///                    final txtTheme = Theme.of(context).textTheme;
  ///                    final colorTheme = Theme.of(context);
  ///                    return SizedBox(
  ///                      height: heightResponsive,
  ///                      width: widthResponsive,
  ///                      child: DecoratedBox(
  ///                        decoration: BoxDecoration(
  ///                          borderRadius: BorderRadius.all(
  ///                            Radius.circular(heightResponsive),
  ///                          ),
  ///                          border: Border.all(
  ///                              color: isyearDisabled
  ///                                  ? colorTheme.disabledColor.withOpacity(0.1)
  ///                                  : isYearselected
  ///                                      ? (colorTheme.brightness ==
  ///                                              Brightness.dark
  ///                                          ? colorTheme.accentColor
  ///                                          : Colors.black)
  ///                                      : Colors.grey,
  ///                              width: isyearDisabled
  ///                                  ? 1
  ///                                  : isYearselected
  ///                                      ? 1.5
  ///                                      : 1),
  ///                        ),
  ///                        child: FittedBox(
  ///                          fit: BoxFit.scaleDown,
  ///                          child: Text(dateTime.year.toString(),
  ///                              style: isyearDisabled
  ///                                  ? txtTheme.caption
  ///                                  : isYearselected
  ///                                      ? txtTheme.button
  ///                                      : txtTheme.button,),
  ///                        ),
  ///                      ),
  ///                    );
  ///                  },
  /// ```
  /// {@end-tool}
  ///
  final WidgetCbYearButton? yearButtonBuilder;

  ///Expanded Height of year dropDown
  ///default = 200
  final double expandedYearHeight;

  ///Expanded Width of year dropDown
  final double? expandedYearWidth;

  ///default  = `false`
  ///Expande year Drop Down initially
  final bool expandYearInitially;
}

///customozer calss for Month button
class MonthButtonCustomizer {
  ///height of month button
  final double? height;

  ///width of month button
  final double? width;

  ///Text Style on Enabled
  final TextStyle? textStyleOnEnabled;

  ///Text Style on Disabled
  final TextStyle? textStyleOnDisabled;

  ///Text Style on Selected
  final TextStyle? textStyleOnSelected;

  ///Text Style on CurrentDay
  final TextStyle? currentDayTextStyle;

  ///Text Style on Highlighted
  final TextStyle? highlightedTextStyle;

  /// color on Disabled
  final Color? colorOnDisabled;

  /// border color on Enabled
  final Color? borderColorOnEnabled;

  /// Highlight  Color/Border Color
  final Color? highlightedColor;

  ///Current Day Color/BorderColor
  final Color? currentDayColor;

  ///color on selected
  final Color? colorOnSelected;

  ///event dot color on Enabled
  final Color? eventColor;

  ///event color on Disabled
  final Color? eventColorOnDisabled;

  ///border Stroke width on Enabled
  final double borderStrokeWidth;

  /// default = `PaintingStyle.stroke`
  final PaintingStyle paintStyleOnEnabled;

  ///Highlighted Button Painting Style
  ///default = `PaintingStyle.stroke`
  final PaintingStyle highlightedPaintingStyle;

  ///CurrentDay Button Painting Style
  ///default = `PaintingStyle.fill`
  final PaintingStyle currentDayPaintingStyle;

  /// default = `PaintingStyle.fill`
  final PaintingStyle paintStyleOnDisabled;

  ///on month Button pressed
  final void Function(DateTime selectedDate)? onPressed;

  ///
  MonthButtonCustomizer({
    this.onPressed,
    this.textStyleOnEnabled,
    this.textStyleOnDisabled,
    this.textStyleOnSelected,
    this.currentDayTextStyle,
    this.highlightedTextStyle,
    this.colorOnDisabled,
    this.borderColorOnEnabled,
    this.colorOnSelected,
    this.eventColor,
    this.eventColorOnDisabled,
    this.highlightedColor,
    this.currentDayColor,
    this.highlightedPaintingStyle = PaintingStyle.stroke,
    this.currentDayPaintingStyle = PaintingStyle.fill,
    this.borderStrokeWidth = 1,
    this.paintStyleOnEnabled = PaintingStyle.stroke,
    this.paintStyleOnDisabled = PaintingStyle.fill,
    this.height,
    this.width,
  });
}

///CUstomiser class for  month

class MonthCustomizer {
  ///CUstomiser class for  month
  MonthCustomizer({
    this.monthHeight = 300,
    this.monthWidth,
    this.scrollToSelectedMonth = false,
    this.shrinkYearDropDownOnScroll = true,
    this.mainAxisSpacing = 20,
    this.crossAxisSpacing = 20,
    this.padding = EdgeInsets.zero,
    this.monthButtonCustomizer,
    this.monthButtonBuilder,
    this.monthHeaderCustomizer,
    this.monthHeaderBuilder,
    this.monthWeekBuilder,
    this.monthWeekCustomizer,
  });

  ///heigh of single month
  final double monthHeight;

  ///width of single month
  final double? monthWidth;

  ///default `scrollToSelectedMonth = false`
  ///
  ///if [scrollToSelectedMonth = true] month will scroll to selected date
  final bool scrollToSelectedMonth;

  ///default = `true`
  ///wether year DropDown Should shrink While Scrolling
  final bool shrinkYearDropDownOnScroll;

  ///The number of logical pixels between each month along the main axis.
  ///
  ///give top & bottom space between  months
  final double mainAxisSpacing;

  ///The number of logical pixels between each month along the cross axis.
  ///
  ///give left & right space between months
  final double crossAxisSpacing;

  ///set padding arround month
  final EdgeInsetsGeometry padding;

  ///Customise month buttons
  final MonthButtonCustomizer? monthButtonCustomizer;

  ///Customize month Header
  final MonthHeaderCustomizer? monthHeaderCustomizer;

  ///Customize month week
  final MonthWeekCustomizer? monthWeekCustomizer;

  ///Build your own month buttons
  ///
  ///* NOTE: COPY & PASTE
  ///*### Sample code
  ///
  /// ```dart
  ///  monthButtonBuilder: (dateTime,childHeight,childWidth,isSelected,isDisabled,hasEvent,isHighlighted,isCurrentDay) {
  ///                    //Text Theme
  ///                    final txtTheme = Theme.of(context).textTheme;
  ///                    //color theme
  ///                    final colorTheme = Theme.of(context);
  ///
  ///                    var daysText = Align(
  ///                      child: Text(
  ///                        '${dateTime.day}',
  ///                        style: isDisabled
  ///                            ? txtTheme.caption
  ///                            : isSelected
  ///                                ? txtTheme.bodyText1!.copyWith(
  ///                                    fontWeight: FontWeight.bold,
  ///                                    color:
  ///                                        colorTheme.brightness == Brightness.dark
  ///                                            ? Colors.black
  ///                                            : Colors.white)
  ///                                : isHighlighted
  ///                                    ? txtTheme.bodyText2 //Highlighted TextStyle
  ///                                    : isCurrentDay
  ///                                        ? txtTheme
  ///                                            .bodyText2 //CurrentDay TextStyle
  ///                                        : txtTheme.bodyText2,
  ///                      ),
  ///                    );
  ///                    return Stack(
  ///                      children: [
  ///                        //if button is Enabled or Disabled
  ///                        isDisabled || !isSelected
  ///                            ? CustomPaint(
  ///                                painter: CirclePainter(
  ///                                  color: isDisabled
  ///                                      ? colorTheme.disabledColor
  ///                                          .withOpacity(0.03)
  ///                                      : isHighlighted
  ///                                          ? colorTheme.accentColor
  ///                                          : isCurrentDay
  ///                                              ? colorTheme.accentColor
  ///                                                  .withOpacity(0.5)
  ///                                              : colorTheme.disabledColor
  ///                                                  .withOpacity(0.05),
  ///                                  style: isDisabled
  ///                                      ? PaintingStyle.fill
  ///                                      : isHighlighted
  ///                                          ? PaintingStyle.stroke
  ///                                          : isCurrentDay
  ///                                              ? PaintingStyle.fill
  ///                                              : PaintingStyle.stroke,
  ///                                  strokeWidth: 1,
  ///                                  radius: childHeight / 2,
  ///                                ),
  ///                                child: daysText,
  ///                              )
  ///                            //if button is Selected
  ///                            : Align(
  ///                                child: SizedBox(
  ///                                  height: childHeight,
  ///                                  width: childWidth,
  ///                                  child: TweenAnimationBuilder<Decoration>(
  ///                                    duration: const Duration(milliseconds: 200),
  ///                                    tween: DecorationTween(
  ///                                      begin: BoxDecoration(
  ///                                          color: colorTheme.accentColor,
  ///                                          shape: BoxShape.circle,
  ///                                          boxShadow: [
  ///                                            BoxShadow(
  ///                                              blurRadius: 5,
  ///                                              color: colorTheme.accentColor
  ///                                                  .withOpacity(0.6),
  ///                                              spreadRadius: 3,
  ///                                            ),
  ///                                          ]),
  ///                                      end: BoxDecoration(
  ///                                        color: colorTheme.accentColor,
  ///                                        shape: BoxShape.circle,
  ///                                      ),
  ///                                    ),
  ///                                    builder: (context, value, child) =>
  ///                                        DecoratedBox(
  ///                                      decoration: value,
  ///                                      child: daysText,
  ///                                    ),
  ///                                  ),
  ///                                ),
  ///                              ),
  ///                        //event button
  ///                        if (hasEvent)
  ///                          Align(
  ///                            alignment: Alignment.bottomCenter,
  ///                            child: CustomPaint(
  ///                              painter: CirclePainter(
  ///                                color: isDisabled
  ///                                    ? colorTheme.disabledColor.withOpacity(0.05)
  ///                                    : colorTheme.accentColor,
  ///                                style: PaintingStyle.fill,
  ///                                strokeWidth: 0,
  ///                                radius: 3,
  ///                                offset: const Offset(0, -4),
  ///                              ),
  ///                            ),
  ///                          ),
  ///                      ],
  ///                    );
  ///                  },
  /// ```
  /// {@end-tool}
  ///
  final WidgetCbMonthButton? monthButtonBuilder;

  ///Build your own weeks
  ///
  ///* NOTE: COPY & PASTE
  ///*### Sample code
  ///
  /// ```dart
  /// monthWeekBuilder: (index, weeks, weekHeight, weekWidth) {
  ///           return SizedBox(
  ///             height: weekHeight,
  ///             width: weekWidth,
  ///             child: Align(
  ///               child: Text(
  ///                 weeks,
  ///                 style: const TextStyle(
  ///                   fontSize: 14,
  ///                   color: Colors.grey,
  ///                   fontWeight: FontWeight.w500,
  ///                 ),
  ///                 overflow: TextOverflow.ellipsis,
  ///                 maxLines: 1,
  ///               ),
  ///             ),
  ///           );
  ///         },

  /// ```
  /// {@end-tool}
  ///
  final WidgetCbMonthWeek? monthWeekBuilder;

  ///Build your own month Headers
  ///
  ///* NOTE: COPY & PASTE
  ///*### Sample code
  ///
  /// ```dart
  /// monthHeaderBuilder:
  ///               (month, headerHeight, headerWidth, paddingLeft) {
  ///             return SizedBox(
  ///               height: headerHeight,
  ///               width: headerWidth,
  ///               child: Padding(
  ///                 padding: EdgeInsets.only(left: paddingLeft),
  ///                 child: Align(
  ///                   alignment: Alignment.centerLeft,
  ///                   child: Text(
  ///                     month,
  ///                     style: const TextStyle(
  ///                       fontSize: 22,
  ///                       fontWeight: FontWeight.w600,
  ///                     ),
  ///                   ),
  ///                 ),
  ///               ),
  ///             );
  ///           },
  /// ```
  /// {@end-tool}
  ///
  final WeidgetCbMonthHeader? monthHeaderBuilder;
}

///Customizer class for moth header
class MonthHeaderCustomizer {
  ///height of year Header
  final double height;

  ///width of year header
  final double? width;

  ///padding o fHeader Text
  final EdgeInsetsGeometry? padding;

  ///Text style of Header Text
  final TextStyle? textStyle;

  ///insert All  12 Months
  ///
  ///* Example
  ///```dart
  ///[
  ///    'January',
  ///    'February',
  ///    'March',
  ///    'April',
  ///    'May',
  ///    'June',
  ///    'July',
  ///    'August',
  ///    'September',
  ///    'October',
  ///    'November',
  ///    'December',
  ///]
  ///````
  /// {@end-tool}
  ///
  final List<String>? monthList;

  ///
  MonthHeaderCustomizer({
    this.height = 40,
    this.width,
    this.padding,
    this.textStyle,
    this.monthList,
  });
}

///Month Weeek customiser
class MonthWeekCustomizer {
  ///height of year Header
  final double height;

  ///Text style of Header Text
  final TextStyle? textStyle;

  ///insert All  7 weeks
  ///
  ///* Example
  ///```dart
  ///[
  ///  'SUN',
  ///  'MON',
  ///  'TUE',
  ///  'WED',
  ///  'THU',
  ///  'FRI',
  ///  'SAT',
  ///]
  ///````
  /// {@end-tool}
  ///
  final List<String>? weekList;

  ///
  MonthWeekCustomizer({
    this.height = 40,
    this.textStyle,
    this.weekList,
  });
}

class OnDateSelected {
  final DateTime selectedDate;
  final bool isSelected;
  final bool isDisabled;
  final bool hasEvent;
  final bool isHighlighted;
  final bool isCurrentDate;
  OnDateSelected({
    required this.selectedDate,
    required this.isSelected,
    required this.isDisabled,
    required this.hasEvent,
    required this.isHighlighted,
    required this.isCurrentDate,
  });
}
