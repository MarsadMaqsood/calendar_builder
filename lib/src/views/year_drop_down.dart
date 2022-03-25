import '../controllers/month_builder_controller.dart';
import '../controllers/month_ui_controller.dart';
import 'package:get/get.dart';

import '../../calendar_builder.dart';
import '../models/month_data_model.dart';
import 'package:flutter/material.dart';

import '../utils/global.dart';

//Todo: Add Image Documentation
///A year Drop down class--- default used in [CbMonthBuilder]
class CbYearDropDown extends StatefulWidget {
  ///
  const CbYearDropDown({
    Key? key,
    this.matchId,
    this.yearHeaderCustomizer,
    this.yearHeaderBuilder,
    this.yearButtonCustomizer,
    this.yearButtonBuilder,
    this.uiStateTag,
    this.expandedYearHeight = 200,
    this.expandedYearWidth,
  }) : super(key: key);

  /// if u want to use same data between your Calendar Builder  -- make sure to give same [matchId]
  final String? matchId;

  ///customise year Header style [YearHeaderCustomizer]
  final YearHeaderCustomizer? yearHeaderCustomizer;

  ///customise year button style [YearButtonCustomizer]
  final YearButtonCustomizer? yearButtonCustomizer;

  ///Build your custom YearDropDown Header
  final WidgetCbYearHeader? yearHeaderBuilder;

  ///Build your own year buttons
  final WidgetCbYearButton? yearButtonBuilder;

  ///Expanded Height of year dropDown
  ///default = 200
  final double expandedYearHeight;

  ///Expanded Width of year dropDown
  final double? expandedYearWidth;

  ///UI controller tag
  final String? uiStateTag;

  @override
  _CbYearDropDownState createState() => _CbYearDropDownState();
}

class _CbYearDropDownState extends State<CbYearDropDown> {
  late String matchingId;
  late String uiStateTag;

  @override
  void initState() {
    super.initState();
    initControlers();
  }

  void initControlers() {
    uiStateTag = widget.uiStateTag ?? UniqueKey().toString();
    Get.put(MonthUiController(), tag: uiStateTag);

    matchingId = widget.matchId ?? UniqueKey().toString();
    Get.put(MonthBuilderController(), tag: matchingId);
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<MonthUiController>(tag: uiStateTag);
    Get.delete<MonthBuilderController>(tag: matchingId);
  }

  @override
  Widget build(BuildContext context) {
    String matchingId = widget.matchId ?? UniqueKey().toString();
    final mUiCtr = Get.find<MonthUiController>(tag: uiStateTag);
    final size = MediaQuery.of(context).size;

    Widget _ifBuilderEmpty = SizedBox(
      height: widget.yearHeaderCustomizer?.height ?? 40,
      width: widget.yearHeaderCustomizer?.width ?? size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<MonthBuilderController>(
              tag: matchingId,
              id: 'dateChangeId',
              builder: (mCtr) {
                String preMonth =
                    mCtr.mSelectedDate.year == mCtr.mSelectedYear.year
                        ? '${CalendarGlobals.months[mCtr.mSelectedDate.month - 1]} - '
                        : '';
                String year = '$preMonth${mCtr.mSelectedYear.year}';
                return Text(
                  year,
                  style: widget.yearHeaderCustomizer?.titleTextStyle ??
                      const TextStyle(fontWeight: FontWeight.bold),
                );
              }),
          GetBuilder<MonthUiController>(
              tag: uiStateTag,
              id: 'monthExpanded',
              builder: (mCtr) => Icon(!mCtr.isYearPickerExpanded
                  ? widget.yearHeaderCustomizer?.downIcon ??
                      Icons.arrow_drop_down_outlined
                  : widget.yearHeaderCustomizer?.upIcon ??
                      Icons.arrow_drop_up_outlined)),
        ],
      ),
    );
    return Column(
      children: [
        InkWell(
          onTap: () {
            mUiCtr.onYearHeaderExpanded?.call(!mUiCtr.isYearPickerExpanded);
            mUiCtr.chageYearExpanded(
                isExpanded: !mUiCtr.isYearPickerExpanded,
                commonUpdateId: 'commonId',
                updateId: 'monthExpanded');
          },
          child: widget.yearHeaderBuilder == null
              ? _ifBuilderEmpty
              : GetBuilder<MonthUiController>(
                  id: 'monthExpanded',
                  tag: uiStateTag,
                  builder: (mUiCtr) => GetBuilder<MonthBuilderController>(
                      id: 'commonId',
                      tag: matchingId,
                      builder: (mCtr) {
                        String preMonth = mCtr.mSelectedDate.year ==
                                mCtr.mSelectedYear.year
                            ? '${CalendarGlobals.months[mCtr.mSelectedDate.month - 1]} - '
                            : '';
                        String year = '$preMonth${mCtr.mSelectedYear.year}';
                        return widget.yearHeaderBuilder!(
                          mUiCtr.isYearPickerExpanded,
                          mCtr.mSelectedDate,
                          mCtr.mSelectedYear,
                          year,
                        );
                      }),
                ),
        ),
        _YearDropDown(
          matchId: matchingId,
          uiStateTag: uiStateTag,
          height: widget.expandedYearHeight,
          width: widget.expandedYearWidth ?? size.width,
          yearButtonBuilder: widget.yearButtonBuilder,
          yearButtonCustomizer: widget.yearButtonCustomizer,
        )
      ],
    );
  }
}

class _YearDropDown extends StatefulWidget {
  const _YearDropDown({
    Key? key,
    required this.matchId,
    required this.uiStateTag,
    required this.height,
    required this.width,
    this.yearButtonBuilder,
    this.yearButtonCustomizer,
  }) : super(key: key);

  final String matchId;
  final String uiStateTag;
  final double height;
  final double width;
  final WidgetCbYearButton? yearButtonBuilder;
  final YearButtonCustomizer? yearButtonCustomizer;

  @override
  __YearDropDownState createState() => __YearDropDownState();
}

class __YearDropDownState extends State<_YearDropDown>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonthUiController>(
      tag: widget.uiStateTag,
      id: 'monthExpanded',
      builder: (mUiCtr) {
        ///!this scrolling will not work while we are using builder
        // WidgetsBinding.instance!.addPostFrameCallback((_) {
        // Scrollable.ensureVisible(
        //     mCtr.mYearPickerGlobalKey[8].currentContext!);
        // });
        return AnimatedSize(
          vsync: this,
          curve: Curves.fastOutSlowIn,
          duration: CalendarGlobals.kMinDuration,
          reverseDuration: CalendarGlobals.kMinDuration,
          child: AnimatedOpacity(
            duration: CalendarGlobals.kMaxDuration,
            opacity: mUiCtr.isYearPickerExpanded ? 1.0 : 0,
            child: SizedBox(
              height: mUiCtr.isYearPickerExpanded ? widget.height : 0,
              width: widget.width,
              child: Visibility(
                ///by using [Visibility] will improve the performace
                visible: mUiCtr.isYearPickerExpanded,
                child: GetBuilder<MonthBuilderController>(
                  id: 'monthExpanded',
                  tag: widget.matchId,
                  builder: (mCtr) => _YearBtnGridBuilder(
                    uiStateTag: widget.uiStateTag,
                    matchId: widget.matchId,
                    height: widget.height,
                    width: widget.width,
                    mCtr: mCtr,
                    isExpanded: mUiCtr.isYearPickerExpanded,
                    yearButtonBuilder: widget.yearButtonBuilder,
                    yearButtonCustomizer: widget.yearButtonCustomizer,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _YearBtnGridBuilder extends StatefulWidget {
  const _YearBtnGridBuilder({
    Key? key,
    required this.height,
    required this.width,
    required this.mCtr,
    required this.isExpanded,
    required this.matchId,
    required this.uiStateTag,
    this.yearButtonBuilder,
    this.yearButtonCustomizer,
  }) : super(key: key);

  final double height;
  final double width;
  final MonthBuilderController mCtr;
  final bool isExpanded;
  final String matchId;
  final String uiStateTag;
  final WidgetCbYearButton? yearButtonBuilder;
  final YearButtonCustomizer? yearButtonCustomizer;

  @override
  __YearBtnGridBuilderState createState() => __YearBtnGridBuilderState();
}

class __YearBtnGridBuilderState extends State<_YearBtnGridBuilder>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _controller;
  late double scrollPosition;

  ///[scrollPosition] it finds the exact scroll position of the [cbYearDropDown]
  ///
  ///
  ///[.truncate] is used to remove fractional part/decimal part
  ///``if val = 1.89
  ///val.truncate()
  ///it returns 1 and removes fractoinal part``
  void _findScrollPositon() {
    scrollPosition = (((((widget.mCtr.m16DateTimeYears.isEmpty
                        ? widget.mCtr.mAllYears.indexWhere((element) =>
                            element.year == widget.mCtr.mSelectedYear.year)
                        : widget.mCtr.m16DateTimeYears.indexWhere((element) =>
                            element.year == widget.mCtr.mSelectedYear.year))) /
                    4)
                .truncate() *
            (widget.height / 4)) -
        (widget.height / 4));
  }

  @override
  void initState() {
    super.initState();
    _findScrollPositon();
    _controller = ScrollController(
        initialScrollOffset: scrollPosition, keepScrollOffset: true);
  }

  @override
  void didUpdateWidget(covariant _YearBtnGridBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      _findScrollPositon();
      _controller.jumpTo(
        scrollPosition,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isMaxSize = widget.width >= 1200;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        ///height of 1 button in grid
        mainAxisExtent: isMaxSize ? widget.height / 3 : widget.height / 4,
        crossAxisCount: isMaxSize ? 5 : 4,
      ),
      //!same
      //  SliverGridDelegateWithMaxCrossAxisExtent(
      //   maxCrossAxisExtent:widget.width / 4,
      //   mainAxisExtent: widget.height / 4,
      // ),
      controller: _controller,
      addAutomaticKeepAlives: true,
      cacheExtent: 20,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.mCtr.m16DateTimeYears.isEmpty
          ? widget.mCtr.mAllYears.length
          : (widget.mCtr.m16DateTimeYears.length - (isMaxSize ? 1 : 0)),
      itemBuilder: (context, i) => GetBuilder<MonthBuilderController>(
        tag: widget.matchId,
        id: widget.mCtr.m16DateTimeYears.isEmpty
            ? widget.mCtr.mAllYears[i]
            : widget.mCtr.m16DateTimeYears[i],
        builder: (mCtr) {
          // Global.debugLogs('Year:$i');
          DateTime thisLoopDate = mCtr.m16DateTimeYears.isEmpty
              ? mCtr.mAllYears[i]
              : mCtr.m16DateTimeYears[i];
          bool isYearselected = DateUtilsCB.checkYearIsSelected(
            ///
            isDisabled: DateUtilsCB.checkDayisDisabled(
                listOfDates: mCtr.mAllYears, date: thisLoopDate),

            ///
            dateSelected: mCtr.mSelectedYear,
            loopedDay: thisLoopDate,
          );
          bool isyearDisabled = DateUtilsCB.checkYearisDisabled(
            listOfDates: mCtr.mAllYears,
            date: thisLoopDate,
          );
          return FittedBox(
            fit: BoxFit.scaleDown,
            child: _YearButtons(
              matchId: widget.matchId,
              uiStateTag: widget.uiStateTag,
              isyearDisabled: isyearDisabled,
              thisLoopDate: thisLoopDate,
              isYearselected: isYearselected,
              height: widget.height,
              width: widget.width,
              builder: widget.yearButtonBuilder,
              borderColorOnDisabled:
                  widget.yearButtonCustomizer?.borderColorOnDisabled,
              borderColorOnEnabled:
                  widget.yearButtonCustomizer?.borderColorOnEnabled,
              borderColorOnSelected:
                  widget.yearButtonCustomizer?.borderColorOnSelected,
              shrinkOnButtonPressed: widget.yearButtonCustomizer == null
                  ? true
                  : widget.yearButtonCustomizer!.shrinkOnButtonPressed,
              hoverColor: widget.yearButtonCustomizer?.hoverColor,
              onPressed: widget.yearButtonCustomizer?.onPressed,
              splashColor: widget.yearButtonCustomizer?.splashColor,
              textColorOnDisabled:
                  widget.yearButtonCustomizer?.textColorOnDisabled,
              textColorOnEnabled:
                  widget.yearButtonCustomizer?.textColorOnEnabled,
              textColorOnSelected:
                  widget.yearButtonCustomizer?.textColorOnSelected,
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _YearButtons extends StatefulWidget {
  const _YearButtons({
    Key? key,
    required this.isyearDisabled,
    required this.thisLoopDate,
    required this.isYearselected,
    required this.height,
    required this.width,
    required this.matchId,
    required this.uiStateTag,
    this.builder,
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
  }) : super(key: key);

  final bool isyearDisabled;
  final DateTime thisLoopDate;
  final bool isYearselected;
  final double height;
  final double width;
  final String matchId;
  final String uiStateTag;
  final WidgetCbYearButton? builder;

  ///
  final Color? borderColorOnSelected;
  final Color? borderColorOnDisabled;
  final Color? borderColorOnEnabled;
  final Color? textColorOnSelected;
  final Color? textColorOnDisabled;
  final Color? textColorOnEnabled;
  final Color? splashColor;
  final Color? hoverColor;
  final Function(bool isButtonDisabled, DateTime selectedYear)? onPressed;
  final bool shrinkOnButtonPressed;
  @override
  __YearButtons createState() => __YearButtons();
}

class __YearButtons extends State<_YearButtons>
    with AutomaticKeepAliveClientMixin {
  ///Callback when a year button is pressed
  void _onYearPressed() {
    final mCtr = Get.find<MonthBuilderController>(tag: widget.matchId);
    final mUiCtr = Get.find<MonthUiController>(tag: widget.uiStateTag);
    if (widget.isyearDisabled) {
      if (widget.onPressed != null) {
        widget.onPressed!(widget.isyearDisabled, widget.thisLoopDate);
      }
      CalendarGlobals.debugLogs('Calendar_builder: year button disabled');
    } else {
      if (widget.onPressed != null) {
        widget.onPressed!(widget.isyearDisabled, widget.thisLoopDate);
      }

      ///Changes selected date
      mCtr.changeSelectedYear(
          selectedYear: widget.thisLoopDate,
          oldSelectedYear: DateTime(mCtr.mSelectedYear.year,
              mCtr.mSelectedYear.month, mCtr.mSelectedYear.day),
          updateByID: true,
          updateId: 'dateChangeId',
          commonUpdateId: 'commonId');

      ///isExpanded
      if (widget.shrinkOnButtonPressed) {
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          mUiCtr.chageYearExpanded(
              isExpanded: false,
              updateId: 'monthExpanded',
              commonUpdateId: 'commonId');
        });
      }

      ///changes the page of month pageView
      int _mPage = mCtr.mAllYears
          .indexWhere((element) => element.year == widget.thisLoopDate.year);
      mUiCtr.mPageController.jumpToPage(_mPage);

      ///saves and removes months if length exedes 3
      mCtr.addToSavedMonthDates(DateTime(mCtr.mSelectedYear.year,
          mCtr.mSelectedYear.month, mCtr.mSelectedYear.day));
      mCtr.savedMonthRemover(DateTime(widget.thisLoopDate.year,
          widget.thisLoopDate.month, widget.thisLoopDate.day));
    }
    mUiCtr.onYearButtonClicked?.call( widget.thisLoopDate,widget.isyearDisabled?false:true);
    
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final txtTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context);

    Widget ifBuilderisEmpty = SizedBox(
      height: (widget.height / 5.5) >= 35 ? 35 : widget.height / 5.5,
      width: (widget.width / 6) >= 150 ? 150 : (widget.width / 6),
      child: InkWell(
        onTap: _onYearPressed,
        splashColor:
            widget.isyearDisabled ? Colors.transparent : widget.splashColor,
        hoverColor: widget.isyearDisabled ? null : widget.hoverColor,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
                (widget.height / 5.5) >= 35 ? 35 : widget.height / 5.5),
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                  (widget.height / 5.5) >= 35 ? 35 : widget.height / 5.5),
            ),
            border: Border.all(
                color: widget.isyearDisabled
                    ? widget.borderColorOnDisabled ??
                        colorTheme.disabledColor.withOpacity(0.1)
                    : widget.isYearselected
                        ? widget.borderColorOnSelected ??
                            (colorTheme.brightness == Brightness.dark
                                ? colorTheme.accentColor
                                : Colors.black)
                        : widget.borderColorOnEnabled ?? Colors.grey,
                width: widget.isyearDisabled
                    ? 1
                    : widget.isYearselected
                        ? 1.5
                        : 1),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(widget.thisLoopDate.year.toString(),
                style: widget.isyearDisabled
                    ? txtTheme.caption!
                        .copyWith(color: widget.textColorOnDisabled)
                    : widget.isYearselected
                        ? txtTheme.button!
                            .copyWith(color: widget.textColorOnSelected)
                        : txtTheme.button!
                            .copyWith(color: widget.textColorOnEnabled)),
          ),
        ),
      ),
    );

    return widget.builder == null
        ? ifBuilderisEmpty
        : GestureDetector(
            onTap: () {
              ///execute functions
              _onYearPressed();
            },
            behavior: HitTestBehavior.opaque,
            child: widget.builder!(
              widget.thisLoopDate,
              (widget.height / 5.5) >= 35 ? 35 : widget.height / 5.5,
              (widget.width / 6) >= 150 ? 150 : (widget.width / 6),
              widget.isyearDisabled,
              widget.isYearselected,
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
