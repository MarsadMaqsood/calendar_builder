// import 'dart:io';

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../calendar_builder.dart';
import '../controllers/cb_controller.dart';
import '../controllers/month_builder_controller.dart';
import '../controllers/month_ui_controller.dart';
import 'year_drop_down.dart';

///Month Builder
class CbMonthBuilder extends StatefulWidget {
  ///constructor of month builder
  const CbMonthBuilder({
    Key? key,
    this.matchId,
    this.height,
    this.width,
    this.yearDropDownCustomizer,
    this.monthCustomizer,
    this.cbConfig,
    this.onYearHeaderExpanded,
    this.onYearButtonClicked,
    this.onDateClicked,
  }) : super(key: key);

  ///* --
  ///*#### NOTE: if you are changing matchId then,  PLEASE DOO HOT RESTART
  /// if u want to use same data between your [ Calendar Builder ] -- make sure to give same [matchId]
  final String? matchId;

  /// Height of [CbMonthBuilder]
  /// Default height = MediaQuery.of(context).size.heigth
  final double? height;

  /// Width of [CbMonthBuilder]
  ///Default width = MediaQuery.of(context).size.width
  final double? width;

  ///Customize Year Drop down
  final YearDropDownCustomizer? yearDropDownCustomizer;

  ///Customise your month
  final MonthCustomizer? monthCustomizer;

  ///Configure all the datas like
  ///
  ///
  ///--  `startDate,`
  ///
  ///--- `endDate,`
  ///
  ///--- `currentDay,`
  ///
  ///--- `selectedDate,`
  ///
  ///--- `selectedYear,`
  ///
  ///--- `eventDates,`
  ///
  ///--- `disabledDates,`
  ///
  ///--- `highlightedDates,`
  ///
  ///--- `weekStartsFrom`
  ///
  final CbConfig? cbConfig;
  final void Function(bool isExpanded)? onYearHeaderExpanded;
  final void Function(DateTime selectedYear, bool isSelected)?
      onYearButtonClicked;
  final void Function(OnDateSelected onDateSelected)? onDateClicked;

  @override
  _CbMonthBuilderState createState() => _CbMonthBuilderState();
}

class _CbMonthBuilderState extends State<CbMonthBuilder> {
  ///Tags of GetxControllers
  ///Data Tag
  late String matchingId;

  ///Matching Isd for `CbConfig`
  late String cbMatchingId;

  ///Ui Tag
  late String uiStateTag;

  @override
  void initState() {
    super.initState();
    Get.config(enableLog: CalendarGlobals.showLogs);
    initControlers();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<MonthUiController>(tag: uiStateTag);
    Get.delete<MonthBuilderController>(tag: matchingId);
    if (!Get.isRegistered<CbController>(tag: cbMatchingId)) {
      Get.delete<CbController>(
        tag: cbMatchingId,
      );
    }
  }

  void initControlers() {
    ///* NOTE
    ///`widget.matchId` concept used only to motch data b/w [CbController()] and `config`
    uiStateTag = UniqueKey().toString();
    Get.put(MonthUiController(), tag: uiStateTag);
    matchingId = UniqueKey().toString();
    Get.put(MonthBuilderController(), tag: matchingId);
    cbMatchingId = widget.matchId ?? UniqueKey().toString();
    Get.put(
      CbController(),
      tag: cbMatchingId,
    );
    expandeYearInitially();
    configDatas(matchingId);
    addToUiCtr();
  }

  void addToUiCtr() {
    final mUiCtr = Get.find<MonthUiController>(tag: uiStateTag);
    mUiCtr.onDateClicked = widget.onDateClicked;
    mUiCtr.onYearButtonClicked = widget.onYearButtonClicked;
    mUiCtr.onYearHeaderExpanded = widget.onYearHeaderExpanded;
  }

  void configDatas(String matchingId, {bool useOnHotReload = false}) {
    final cbCtr = Get.find<CbController>(tag: cbMatchingId);
    final mCtr = Get.find<MonthBuilderController>(tag: matchingId);

    if (widget.cbConfig != null) {
      cbCtr.changeConfig(widget.cbConfig!);
    }

    ///
    mCtr.config(config: cbCtr.cbConfig, useOnHotReload: useOnHotReload);
  }

  void expandeYearInitially() {
    final mUiCtr = Get.find<MonthUiController>(tag: uiStateTag);

    mUiCtr.expandInitiaally(
        widget.yearDropDownCustomizer?.expandYearInitially ?? false);
  }

  @override
  void didUpdateWidget(covariant CbMonthBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    final mCtr = Get.find<MonthBuilderController>(tag: matchingId);

    if (oldWidget.yearDropDownCustomizer?.expandYearInitially !=
        widget.yearDropDownCustomizer?.expandYearInitially) {
      expandeYearInitially();
    }

    ///
    if (oldWidget.cbConfig?.selectedDate != widget.cbConfig?.selectedDate) {
      DateTime oldDate = oldWidget.cbConfig?.selectedDate ?? DateTime.now();
      DateTime newDate = widget.cbConfig?.selectedDate ?? DateTime.now();
      mCtr.changeSelectedDate(
          selectedDate: newDate,
          oldSelectedDate: DateTime(oldDate.year, oldDate.month, oldDate.day),
          updateByID: true,
          updateId: 'dateChangeId',
          commonUpdateId: 'commonId');
    }
    if (oldWidget.cbConfig?.selectedYear != widget.cbConfig?.selectedYear) {
      DateTime oldDate =
          oldWidget.cbConfig?.selectedYear ?? DateTime(DateTime.now().year);
      DateTime newDate =
          widget.cbConfig?.selectedYear ?? DateTime(DateTime.now().year);
      changeYear(oldDate: oldDate, newDate: newDate);
    }
    if (oldWidget.cbConfig != widget.cbConfig) {
      configDatas(matchingId, useOnHotReload: true);
    }
    addToUiCtr();

    ///
  }

  void changeYear({required DateTime oldDate, required DateTime newDate}) {
    final mUiCtr = Get.find<MonthUiController>(tag: uiStateTag);
    final mCtr = Get.find<MonthBuilderController>(tag: matchingId);

    ///Changes selected date
    mCtr.changeSelectedYear(
        selectedYear: newDate,
        oldSelectedYear: DateTime(oldDate.year, oldDate.month, oldDate.day),
        updateByID: true,
        updateId: 'dateChangeId',
        commonUpdateId: 'commonId');

    ///isExpanded
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      mUiCtr.chageYearExpanded(
          isExpanded: false,
          updateId: 'monthExpanded',
          commonUpdateId: 'commonId');
    });

    ///changes the page of month pageView
    int _mPage =
        mCtr.mAllYears.indexWhere((element) => element.year == newDate.year);
    mUiCtr.mPageController.jumpToPage(_mPage);

    ///saves and removes months if length exedes 3
    mCtr.addToSavedMonthDates(
        DateTime(newDate.year, newDate.month, newDate.day));
    mCtr.savedMonthRemover(DateTime(newDate.year, newDate.month, newDate.day));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double cbMonthHeight = widget.height ??
        (size.height -
            MediaQuery.of(context).viewPadding.bottom -
            MediaQuery.of(context).viewPadding.top);
    double cbMonthWidth = widget.width ?? size.width;

    return SafeArea(
      child: SizedBox(
        height: cbMonthHeight,
        width: cbMonthWidth,
        child: Column(children: [
          CbYearDropDown(
            matchId: matchingId,
            uiStateTag: uiStateTag,
            expandedYearHeight:
                widget.yearDropDownCustomizer?.expandedYearHeight ?? 200,
            expandedYearWidth: widget.yearDropDownCustomizer?.expandedYearWidth,
            yearButtonBuilder: widget.yearDropDownCustomizer?.yearButtonBuilder,
            yearButtonCustomizer:
                widget.yearDropDownCustomizer?.yearButtonCustomizer,
            yearHeaderBuilder: widget.yearDropDownCustomizer?.yearHeaderBuilder,
            yearHeaderCustomizer:
                widget.yearDropDownCustomizer?.yearHeaderCustomizer,
          ),
          const Divider(
            endIndent: 0,
            indent: 0,
            height: 0,
            thickness: 1,
          ),
          Expanded(
            child: _MonthView(
              matchingId: matchingId,
              cbMonthHeight: cbMonthHeight,
              yearDropDownCustomizer: widget.yearDropDownCustomizer,
              uiStateTag: uiStateTag,
              monthCustomizer: widget.monthCustomizer,
            ),
          ),
        ]),
      ),
    );
  }
}

class _MonthView extends StatefulWidget {
  const _MonthView({
    Key? key,
    required this.matchingId,
    required this.cbMonthHeight,
    this.yearDropDownCustomizer,
    this.monthCustomizer,
    required this.uiStateTag,
  }) : super(key: key);

  final String matchingId;
  final double cbMonthHeight;
  final YearDropDownCustomizer? yearDropDownCustomizer;
  final MonthCustomizer? monthCustomizer;
  final String uiStateTag;

  @override
  __MonthViewState createState() => __MonthViewState();
}

class __MonthViewState extends State<_MonthView> {
  @override
  void initState() {
    super.initState();
    pageInitialise();
  }

  void pageInitialise() {
    final mUiCtr = Get.find<MonthUiController>(tag: widget.uiStateTag);
    final mCtr = Get.find<MonthBuilderController>(tag: widget.matchingId);
    int _initialPage = mCtr.mAllYears
        .indexWhere((element) => element.year == mCtr.mSelectedYear.year);
    mUiCtr.mPageController =
        PageController(initialPage: _initialPage, keepPage: true);
    mCtr.addToSavedMonthDates(DateTime(mCtr.mSelectedYear.year,
        mCtr.mSelectedYear.month, mCtr.mSelectedYear.day));
    //  thisSelectedYear = DateTime(mCtr.mSelectedYear.year,
    //     mCtr.mSelectedYear.month, mCtr.mSelectedYear.day);
  }

  @override
  void didUpdateWidget(covariant _MonthView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.matchingId != widget.matchingId) {
      pageInitialise();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mCtr = Get.find<MonthBuilderController>(tag: widget.matchingId);
    final mUiCtr = Get.find<MonthUiController>(tag: widget.uiStateTag);
    // height: widget.cbMonthHeight -
    //     ((widget.yearDropDownCustomizer?.yearHeaderCustomizer?.height ??
    //         40))
    return PageView.builder(
      itemCount: mCtr.mAllYears.length,
      controller: mUiCtr.mPageController,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        DateTime thisSelectedYear = mCtr.mAllYears.elementAt(index);
        Widget _monthGrid() {
          return _MonthGrid(
            matchingId: widget.matchingId,
            uiStateTag: widget.uiStateTag,
            monthCustomizer: widget.monthCustomizer,
            thisSelectedYear: thisSelectedYear,
          );
        }

        CalendarGlobals.debugLogs('page: $index');
        return GetBuilder<MonthBuilderController>(
            id: 'removedDate:$thisSelectedYear!',
            tag: widget.matchingId,
            builder: (mCtr) {
              CalendarGlobals.debugLogs(thisSelectedYear);
              return mCtr.removedDate == thisSelectedYear
                  ? const SizedBox()
                  : _monthGrid();
            });
      },
    );
  }
}

class _MonthGrid extends StatefulWidget {
  const _MonthGrid({
    Key? key,
    required this.matchingId,
    required this.uiStateTag,
    required this.thisSelectedYear,
    this.monthCustomizer,
  }) : super(key: key);
  final String matchingId;
  final String uiStateTag;
  final MonthCustomizer? monthCustomizer;
  final DateTime thisSelectedYear;
  @override
  __MonthGridState createState() => __MonthGridState();
}

class __MonthGridState extends State<_MonthGrid> {
  late final ScrollController _scrollController;
  late final double _initialSrollOffset;
  @override
  void initState() {
    super.initState();
    monthScrollConfig();
  }

  void monthScrollConfig() {
    final bool scrollToSelectedMonth =
        widget.monthCustomizer?.scrollToSelectedMonth ?? false;
    final mCtr = Get.find<MonthBuilderController>(tag: widget.matchingId);

    ///initially scroll to the perticular selected month if [scrollToSelectedMonth = true]
    if (mCtr.mSelectedDate.year != widget.thisSelectedYear.year ||
        !scrollToSelectedMonth) {
      _initialSrollOffset = 0;
    } else {
      _initialSrollOffset = ((widget.monthCustomizer?.monthHeight ?? 300) +
              (widget.monthCustomizer?.monthHeaderCustomizer?.height ?? 40) +
              (widget.monthCustomizer?.monthWeekCustomizer?.height ?? 40)) *
          (mCtr.mSelectedDate.month - 1);
    }
    _scrollController = ScrollController(
        initialScrollOffset: _initialSrollOffset, keepScrollOffset: false);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (widget.monthCustomizer?.shrinkYearDropDownOnScroll ?? true) {
            ///used to check whether the scroll  is started or not
            if (notification is ScrollStartNotification) {
              ///if scrolling is started the [cbYearDropDown]  expand = false
              final mUiCtr =
                  Get.find<MonthUiController>(tag: widget.uiStateTag);
              mUiCtr.chageYearExpanded(
                isExpanded: false,
                updateId: 'monthExpanded',
                commonUpdateId: 'commonId',
              );
            }
          }

          return true;
        },
        child: GridView.builder(
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 1, mainAxisExtent: 340),
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: widget.monthCustomizer?.monthWidth ??
                maxCrossAxisExtentCounter(context),
            mainAxisExtent: ((widget.monthCustomizer?.monthHeight ?? 300) +
                (widget.monthCustomizer?.monthHeaderCustomizer?.height ?? 40) +
                (widget.monthCustomizer?.monthWeekCustomizer?.height ?? 40)),
            crossAxisSpacing: widget.monthCustomizer?.crossAxisSpacing ?? 20,
            mainAxisSpacing: widget.monthCustomizer?.mainAxisSpacing ?? 20,
          ),
          padding: widget.monthCustomizer?.padding ?? EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 12,
          itemBuilder: (context, index) {
            CalendarGlobals.debugLogs('month $index');
            // return Text('data');
            return SingleMonthView(
              matchId: widget.matchingId,
              uiStateTag: widget.uiStateTag,
              monthIndex: index,
              monthCustomizer: widget.monthCustomizer,
              thisSelectedYear: widget.thisSelectedYear,
            );
          },
        ));
  }

  ///responsive month grid
  double maxCrossAxisExtentCounter(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    if (kIsWeb) {
      return 700;
    }
    if (mq.orientation == Orientation.portrait &&
        (Platform.isAndroid || Platform.isIOS)) {
      return size.width;
    } else if (mq.orientation == Orientation.landscape &&
        (Platform.isAndroid || Platform.isIOS)) {
      return size.width / 2;
    }
    return 700;
  }
}

///This widget contains the design and logics of single month
class SingleMonthView extends StatelessWidget {
  ///
  const SingleMonthView({
    Key? key,
    required this.matchId,
    required this.uiStateTag,
    required this.monthIndex,
    this.monthCustomizer,
    required this.thisSelectedYear,
  }) : super(key: key);

  ///Tags of GetxControllers
  ///Data Tag
  final String matchId;
  //ui tag
  final String uiStateTag;

  ///index of month 0-12
  final int monthIndex;

  ///Month Customizer
  final MonthCustomizer? monthCustomizer;

  ///selected year of this page
  final DateTime thisSelectedYear;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mCtr = Get.find<MonthBuilderController>(tag: matchId);

    double monthWidth = size.width;
    double monthHeight = monthCustomizer?.monthHeight ?? 300;
    double buttonHeight = monthHeight / 6;
    late double buttonWidth;
    double buttonChildHeight =
        monthCustomizer?.monthButtonCustomizer?.height ?? (buttonHeight / 1.5);
    double buttonChildWidth =
        monthCustomizer?.monthButtonCustomizer?.width ?? buttonHeight / 1.5;

    late double paddingLeft;
    double weekHeight = monthCustomizer?.monthWeekCustomizer?.height ?? 40;

    ///default = [WeekStartsFrom.sunday]
    int weekSelectedIndex =
        (WeekStartsFrom.values.indexOf(mCtr.mWeekStartsFrom));

    // List<String> weeks =
    // monthCustomizer?.weekStartsFrom == WeekStartsFrom.monday
    //     ? Global.weeksStartsMonday
    //     : monthCustomizer?.weekStartsFrom == WeekStartsFrom.saturday
    //         ? Global.weeksStartsSaturday
    //         : Global.weeksStartsSunday;

    double headerHeight = monthCustomizer?.monthHeaderCustomizer?.height ?? 40;
    double headerWidth =
        monthCustomizer?.monthHeaderCustomizer?.width ?? size.width;
    final EdgeInsetsGeometry? padding =
        monthCustomizer?.monthHeaderCustomizer?.padding;
    final TextStyle? textStyleHeader =
        monthCustomizer?.monthHeaderCustomizer?.textStyle;
    final TextStyle? textStyleWeeek =
        monthCustomizer?.monthWeekCustomizer?.textStyle;

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            ///[max()] is used to make -negetive values to zero
            ///[max()] imported from ['dart:math'];
            paddingLeft = max(
                0, (((constraints.maxWidth / 7) / 2) - (buttonChildWidth / 2)));
            final List<String>? userMonths =
                monthCustomizer?.monthHeaderCustomizer?.monthList;
            if (userMonths != null) {
              assert(!(userMonths.length < 12),
                  '\n\nERROR ( Calendar Builder ):\n---------\nInside MonthHeaderCustomizer()\nmonthList length Should be equal to 12\n---------\n_');
            }

            var ifHeaderBuilderEmpty = SizedBox(
              height: headerHeight,
              width: headerWidth,
              child: Padding(
                padding: padding ?? EdgeInsets.only(left: paddingLeft),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userMonths?[monthIndex] ??
                        CalendarGlobals.months[monthIndex],
                    style: textStyleHeader ??
                        const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            );
            return monthCustomizer?.monthHeaderBuilder == null
                ? ifHeaderBuilderEmpty
                : monthCustomizer!.monthHeaderBuilder!(
                    CalendarGlobals.months[monthIndex],
                    headerHeight,
                    headerWidth,
                    paddingLeft,
                  );
          },
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            buttonWidth = constraints.maxWidth / 7;
            return Row(
                children: List.generate(7, (weekIndex) {
              List<String>? userWeek =
                  monthCustomizer?.monthWeekCustomizer?.weekList;
              if (userWeek != null) {
                assert(!(userWeek.length < 7),
                    '\n\nERROR ( Calendar Builder ):\n---------\nInside MonthWeekCustomizer()\nWeekList length Should be equal to 7\n---------\n_');
              }

              ///if empty
              var ifWeekBuilderEmpty = SizedBox(
                height: weekHeight,
                width: buttonWidth,
                child: Align(
                  child: Text(
                    userWeek?[weekIndex] ??
                        CalendarGlobals.weeksStarter[weekSelectedIndex]
                            [weekIndex],
                    style: textStyleWeeek ??
                        const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              );
              return monthCustomizer?.monthWeekBuilder == null
                  ? ifWeekBuilderEmpty
                  : monthCustomizer!.monthWeekBuilder!(
                      weekIndex,
                      CalendarGlobals.weeksStarter[weekSelectedIndex]
                          [weekIndex],
                      weekHeight,
                      buttonWidth,
                    );
            }));
          },
        ),
        SizedBox(
          height: monthHeight,
          width: monthWidth,
          child: _MonthButtonGrid(
            matchId: matchId,
            uiStateTag: uiStateTag,
            monthHeight: monthHeight,
            monthWidth: monthWidth,
            monthIndex: monthIndex,
            buttonChildWidth: buttonChildWidth,
            buttonChildHeight: buttonChildHeight,
            monthCustomizer: monthCustomizer,
            thisSelectedYear: thisSelectedYear,
          ),
        ),
      ],
    );
  }
}

class _MonthButtonGrid extends StatefulWidget {
  const _MonthButtonGrid({
    Key? key,
    required this.matchId,
    required this.monthHeight,
    required this.uiStateTag,
    required this.monthWidth,
    required this.buttonChildHeight,
    required this.buttonChildWidth,
    required this.thisSelectedYear,
    this.monthCustomizer,
    required this.monthIndex,
  }) : super(key: key);
  final String matchId;
  final double monthHeight;
  final String uiStateTag;
  final double monthWidth;
  final double buttonChildHeight;
  final double buttonChildWidth;
  final DateTime thisSelectedYear;

  ///Month Customizer
  final MonthCustomizer? monthCustomizer;

  ///index of month 0-12
  final int monthIndex;

  @override
  __MonthButtonGridState createState() => __MonthButtonGridState();
}

class __MonthButtonGridState extends State<_MonthButtonGrid>
    with AutomaticKeepAliveClientMixin {
  ///logic for all 42 days in month
  ///including previous & after month disabled month dates
  late List<DateTime> mAll42DaysInMonth;

  ///contains only the exact same months
  late List<DateTime> mCorrectMonths;

  ///Check for Disabled Days in Month
  bool checkDayIsDisabled = false;

  ///Check for Selected Days in Month
  bool checkDayIsSelected = false;

  ///Check for Highlighted Days in Month
  bool checkHighlightedDates = false;

  ///Check is this is current day in Month
  bool checkCurrentDay = false;

  ///check for events
  late bool checkHasEvent;

  @override
  void initState() {
    super.initState();
    _initMonthLogic();
  }

  void _initMonthLogic() {
    final mCtr = Get.find<MonthBuilderController>(tag: widget.matchId);
    build42Days(weekStartsFrom: mCtr.mWeekStartsFrom);
    mCorrectMonths = DateUtilsCB.getAllMonthsIn1Year(
      selectedYear: widget.thisSelectedYear,

      ///!latest removed #1
      // allDates: mCtr.mAllDates,
    )[widget.monthIndex]
        .values
        .first;
  }

  void build42Days({WeekStartsFrom? weekStartsFrom}) {
    mAll42DaysInMonth = DateUtilsCB.getAll42DaysIn1Month(
      weekStartsFrom: weekStartsFrom ?? WeekStartsFrom.sunday,
      month: DateUtilsCB.getAllMonthsIn1Year(
        selectedYear: widget.thisSelectedYear,

        ///!latest removed #1
        // allDates: mCtr.mAllDates,
      )[widget.monthIndex]
          .values
          .first,
    );
  }

  @override
  void didUpdateWidget(covariant _MonthButtonGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    final mCtr = Get.find<MonthBuilderController>(tag: widget.matchId);
    _initMonthLogic();

    if (widget.monthCustomizer != oldWidget.monthCustomizer) {
      build42Days(weekStartsFrom: mCtr.mWeekStartsFrom);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        ///height of 1 button in grid
        mainAxisExtent: widget.monthHeight / 6,
        crossAxisCount: 7,
      ),
      itemCount: mAll42DaysInMonth.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return GetBuilder<MonthBuilderController>(
            id: mAll42DaysInMonth[index],
            tag: widget.matchId,
            builder: (mCtr) {
              // Global.debugLogs('grid Btn $index month${widget.monthIndex}');
              _checkingMonthDays(
                  index: index, selectedDate: mCtr.mSelectedDate);
              var _monthButtons = _MonthButtons(
                mAll42DaysInMonth: mAll42DaysInMonth,
                index: index,
                isDisabled: checkDayIsDisabled,
                isSelected: checkDayIsSelected,
                isCurrentDay: checkCurrentDay,
                hasEvent: checkHasEvent,
                buttonChildHeight: widget.buttonChildHeight,
                buttonChildWidth: widget.buttonChildWidth,
                monthCustomizer: widget.monthCustomizer,
                isHighlighted: checkHighlightedDates,
              );
              return checkDayIsDisabled
                  ? GestureDetector(
                      onTap: () {
                        _checkingMonthDays(
                            index: index, selectedDate: mCtr.mSelectedDate);

                        final mUiCtr =
                            Get.find<MonthUiController>(tag: widget.uiStateTag);
                        mUiCtr.onDateClicked?.call(
                          OnDateSelected(
                            selectedDate: mAll42DaysInMonth[index],
                            isSelected: checkDayIsSelected,
                            isDisabled: checkDayIsDisabled,
                            hasEvent: checkHasEvent,
                            isHighlighted: checkHighlightedDates,
                            isCurrentDate: checkCurrentDay,
                          ),
                        );
                      },
                      child: _monthButtons)
                  : GestureDetector(
                      onTap: () {
                        _checkingMonthDays(
                            index: index, selectedDate: mCtr.mSelectedDate);

                        final mUiCtr =
                            Get.find<MonthUiController>(tag: widget.uiStateTag);
                        mUiCtr.onDateClicked?.call(
                          OnDateSelected(
                            selectedDate: mAll42DaysInMonth[index],
                            isSelected: checkDayIsSelected,
                            isDisabled: checkDayIsDisabled,
                            hasEvent: checkHasEvent,
                            isHighlighted: checkHighlightedDates,
                            isCurrentDate: checkCurrentDay,
                          ),
                        );

                        ///execute functions
                        mCtr.changeSelectedDate(
                            selectedDate: mAll42DaysInMonth[index],
                            oldSelectedDate: DateTime(
                                mCtr.mSelectedDate.year,
                                mCtr.mSelectedDate.month,
                                mCtr.mSelectedDate.day),
                            updateByID: true,
                            updateId: 'dateChangeId',
                            commonUpdateId: 'commonId');
                        // custom onPressed
                        if (widget.monthCustomizer?.monthButtonCustomizer
                                ?.onPressed !=
                            null) {
                          widget.monthCustomizer?.monthButtonCustomizer
                              ?.onPressed!(mAll42DaysInMonth[index]);
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      //Parent Container
                      child: _monthButtons);
            });
      },
    );
  }

  void _checkingMonthDays(
      {required int index, required DateTime selectedDate}) {
    final mCtr = Get.find<MonthBuilderController>(tag: widget.matchId);

    ///Check for Disabled Days
    ///In month
    checkDayIsDisabled = DateUtilsCB.checkDayisDisabled(
        listOfDates: mCorrectMonths, date: mAll42DaysInMonth[index]);

    ///Check for Disabled days
    ///i.e after [mStartDate]
    if (!checkDayIsDisabled) {
      ///ignores if [mStartDate] is = to [mAll42DaysInMonth[index]]
      if (!DateUtilsCB.checkDayisSelected(
          dateSelected: mAll42DaysInMonth[index], loopedDay: mCtr.mStartDate)) {
        checkDayIsDisabled = mAll42DaysInMonth[index].isBefore(mCtr.mStartDate);
      }
    }

    ///Check for Disabled days
    ///i.e after [mEndDate]
    if (!checkDayIsDisabled) {
      checkDayIsDisabled = mAll42DaysInMonth[index].isAfter(mCtr.mEndDate);
    }

    ///checking if user disabled any dates
    if (!checkDayIsDisabled) {
      checkDayIsDisabled = DateUtilsCB.checkListContainsDate(
          listOfDates: mCtr.mDisabledDates, date: mAll42DaysInMonth[index]);
    }

    ///checking for Selected days
    checkDayIsSelected = DateUtilsCB.checkDayisSelected(
        dateSelected: selectedDate, loopedDay: mAll42DaysInMonth[index]);

    if (!checkDayIsSelected && !checkDayIsDisabled) {
      checkHighlightedDates = DateUtilsCB.checkListContainsDate(
          listOfDates: mCtr.mHighlightedDates, date: mAll42DaysInMonth[index]);
      if (!checkHighlightedDates) {
        checkCurrentDay = DateUtilsCB.checkDayisSelected(
            dateSelected: mCtr.mCurrentDay,
            loopedDay: mAll42DaysInMonth[index]);
      }
    }

    ///checking for events
    checkHasEvent = DateUtilsCB.checkListContainsDate(
        listOfDates: mCtr.mEventDates
            .where((element) =>
                element.year == mAll42DaysInMonth[index].year &&
                element.month == mAll42DaysInMonth[index].month)
            .toList(),
        date: mAll42DaysInMonth[index]);
  }

  @override
  bool get wantKeepAlive => true;
}

class _MonthButtons extends StatelessWidget {
  const _MonthButtons({
    Key? key,
    required this.mAll42DaysInMonth,
    required this.index,
    required this.isDisabled,
    required this.isSelected,
    required this.isHighlighted,
    required this.isCurrentDay,
    required this.buttonChildHeight,
    required this.buttonChildWidth,
    required this.hasEvent,
    this.monthCustomizer,
  }) : super(key: key);

  final List<DateTime> mAll42DaysInMonth;
  final int index;
  final bool isDisabled;
  final bool isSelected;
  final bool hasEvent;
  final bool isHighlighted;
  final bool isCurrentDay;
  final double buttonChildHeight;
  final double buttonChildWidth;
  final MonthCustomizer? monthCustomizer;

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final MonthButtonCustomizer? _mBtn = monthCustomizer?.monthButtonCustomizer;
    final colorTheme = Theme.of(context);

    var daysText = Align(
        child: Text(
      '${mAll42DaysInMonth[index].day}',
      style: isDisabled
          ? _mBtn?.textStyleOnDisabled ?? txtTheme.caption
          : isSelected
              ? _mBtn?.textStyleOnSelected ??
                  txtTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorTheme.brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white)
              : isHighlighted
                  ? _mBtn?.highlightedTextStyle ?? txtTheme.bodyText2
                  : isCurrentDay
                      ? _mBtn?.currentDayTextStyle ?? txtTheme.bodyText2
                      : _mBtn?.textStyleOnEnabled ?? txtTheme.bodyText2,
    ));
    var ifBuilderIsEmpty = Stack(
      alignment: Alignment.center,
      children: [
        isDisabled || !isSelected
            ? CustomPaint(
                size: Size(buttonChildHeight, buttonChildWidth),
                painter: CirclePainter(
                    color: isDisabled
                        ? _mBtn?.colorOnDisabled ??
                            colorTheme.disabledColor.withOpacity(0.03)
                        : isHighlighted
                            ? _mBtn?.highlightedColor ??
                                colorTheme.colorScheme.secondary
                            : isCurrentDay
                                ? _mBtn?.currentDayColor ??
                                    colorTheme.colorScheme.secondary
                                        .withOpacity(0.5)
                                : _mBtn?.borderColorOnEnabled ??
                                    colorTheme.disabledColor.withOpacity(0.05),
                    style: isDisabled
                        ? _mBtn?.paintStyleOnDisabled ?? PaintingStyle.fill
                        : isHighlighted
                            ? _mBtn?.highlightedPaintingStyle ??
                                PaintingStyle.stroke
                            : isCurrentDay
                                ? _mBtn?.currentDayPaintingStyle ??
                                    PaintingStyle.fill
                                : _mBtn?.paintStyleOnEnabled ??
                                    PaintingStyle.stroke,
                    strokeWidth: _mBtn?.borderStrokeWidth ?? 1,
                    radius: buttonChildHeight / 2),
                child: daysText)
            : SizedBox(
                height: buttonChildHeight,
                width: buttonChildWidth,
                child: TweenAnimationBuilder<Decoration>(
                    duration: const Duration(milliseconds: 200),
                    tween: DecorationTween(
                      begin: BoxDecoration(
                          color: _mBtn?.colorOnSelected ??
                              colorTheme.colorScheme.secondary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color:
                                    _mBtn?.colorOnSelected?.withOpacity(0.6) ??
                                        colorTheme.colorScheme.secondary
                                            .withOpacity(0.6),
                                spreadRadius: 3),
                          ]),
                      end: BoxDecoration(
                        color: _mBtn?.colorOnSelected ??
                            colorTheme.colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    builder: (context, value, child) => DecoratedBox(
                          decoration: value,
                          child: daysText,
                        )),
              ),
        if (hasEvent)
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: CirclePainter(
                  color: isDisabled
                      ? _mBtn?.eventColorOnDisabled ??
                          colorTheme.disabledColor.withOpacity(0.05)
                      : _mBtn?.eventColor ?? colorTheme.colorScheme.secondary,
                  style: PaintingStyle.fill,
                  strokeWidth: 0,
                  radius: 3,
                  offset: const Offset(0, -4)),
            ),
          ),
      ],
    );
    return monthCustomizer?.monthButtonBuilder == null
        ? ifBuilderIsEmpty
        : monthCustomizer!.monthButtonBuilder!(
            mAll42DaysInMonth[index],
            buttonChildHeight,
            buttonChildWidth,
            isSelected,
            isDisabled,
            hasEvent,
            isHighlighted,
            isCurrentDay);
  }
}
