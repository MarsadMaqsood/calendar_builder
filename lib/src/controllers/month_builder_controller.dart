import 'package:calendar_builder/src/models/cb_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../calendar_builder.dart';

/// State manager or  controller of MonthBuilder
class MonthBuilderController extends GetxController {
  ///startDate of month
  DateTime mStartDate = DateTime(DateTime.now().year);

  /// EndDate of month
  /// default one year greater than [mStartDate]
  /// [endDate] should be greater than [startDate]
  DateTime mEndDate =
      DateTime(DateTime.now().year + 20).subtract(const Duration(days: 1));

  ///Current day/Todays Date of Birth"
  ///default = now
  DateTime mCurrentDay = DateTime.now();

  ///this contains all the  [DateTime] from [mStartDate] to [mEndDate] with [mEndDate]+its full year
  ///!minimum 1 year dates will be there
  late List<DateTime> mAllDates;

  ///this contains all the  [DateTime] from [mStartDate] to [mEndDate]
  late List<DateTime> mStartToEndDates;

  ///this contains all the dateTime sorted in the basis of years from [mStartDate] to [mEndDate]
  ///!minimum 1 year  will be there
  late List<DateTime> mAllYears;

  ///lits of 16 dates for year dropDown
  late List<DateTime> m16DateTimeYears;

  ///Slected Date
  ///default = [mStartDate]
  DateTime mSelectedDate = DateTime.now();

  ///Slected Year
  ///default = [DateTime(mStartDate.year)]
  DateTime mSelectedYear = DateTime(DateTime.now().year);

  ///all events dates
  List<DateTime> mEventDates = [];

  ///all disabled dates
  List<DateTime> mDisabledDates = [];

  ///all hilighted dates
  List<DateTime> mHighlightedDates = [];

  ///weeek start from
  ///default = `WeekStartsFrom.sunday`
  WeekStartsFrom mWeekStartsFrom = WeekStartsFrom.sunday;

  ///used to improve the performance of [monthBuilder]
  ///wee add all the datas using [addToSavedMonthDates] function
  ///and theen [savedMonthRemover] this function removers dates
  ///if [savedMonthDatas.length] exceeds 3
  ///
  List<DateTime> savedMonthDatas = [];

  ///removed date from [savedMonthDatas]
  DateTime? removedDate;

  ///all month start up logic
  void _logicInitialization() {
    ///alll the dates form [mStartDate] to [mEndDate]
    mStartToEndDates = DateUtilsCB.getDaysInBeteween(
        startDate: mStartDate, endDate: mEndDate);

    ///all the dates in each the year
    mAllDates = DateUtilsCB.getAllDaysInBetweenYears(
        startDate: mStartDate, endDate: mEndDate);

    ///gets all the years form [mStartDate] to [mEndDate]
    mAllYears = DateUtilsCB.getYearsInBeteween(
        startDate: mStartDate, endDate: mEndDate);

    _yearBuilderLogic();
  }

  ///configaration for month builder
  void config({CbConfig? config, bool useOnHotReload = false}) {
    if (useOnHotReload == false) {
      mStartDate = config?.startDate ?? DateTime(DateTime.now().year);
    }
    mEndDate = config?.endDate ??
        DateTime(DateTime.now().year + 20).subtract(const Duration(days: 1));

    ///
    if (useOnHotReload == false) {
      mSelectedDate = config?.selectedDate ?? DateTime.now();
      mSelectedYear = config?.selectedYear ?? DateTime(mStartDate.year);
    }
    mCurrentDay = config?.currentDay ?? DateTime.now();
    mWeekStartsFrom = config?.weekStartsFrom ?? WeekStartsFrom.sunday;
    mEventDates = config?.eventDates ?? [];
    mHighlightedDates = config?.highlightedDates ?? [];
    mDisabledDates = config?.disabledDates ?? [];
    _logicInitialization();
  }

  ///For Improving Performace
  ///Add selectedYear to savedMonthDatas --- to save data
  void addToSavedMonthDates(DateTime date) {
    savedMonthDatas.add(date);
    savedMonthDatas = savedMonthDatas.toSet().toList();
  }

  ///For Improving Performace
  ///to check wether the saved month size exceeds 3
  ///if excedes it removes previous cached datas 
  void savedMonthRemover(DateTime date) {
    print('-----$date');
    if (savedMonthDatas.length > 3) {
      if (savedMonthDatas[0] != date) {
        removedDate = savedMonthDatas[0];
        savedMonthDatas.removeAt(0);
        update(['removedDate:$removedDate!']);
        print('removedDate:$removedDate!');
      } else {
        removedDate = null;
      }
    } else {
      removedDate = null;
    }
  }

  ///Checking  [mAllYears]
  ///because to get alll the 16 days to fill the boxes in [UI]
  void _yearBuilderLogic() {
    if (mAllYears.length < 16) {
      m16DateTimeYears = DateUtilsCB.getYearsInBeteween(
        startDate: mStartDate,
        endDate: DateTime(mAllYears.last.year + (16 - (mAllYears.length))),
      );
    } else {
      m16DateTimeYears = [];
    }
  }

  ///fuction to update Selected Date [mSelectedDate]
  void changeSelectedDate({
    required DateTime selectedDate,
    DateTime? oldSelectedDate,
    required String commonUpdateId,
    String? updateId,
    bool updateByID = false,
  }) {
    mSelectedDate = selectedDate;
    //common update Id for date changes
    update([commonUpdateId]);
    print('old:$oldSelectedDate');
    print('selcted:$selectedDate');
    if (updateByID && oldSelectedDate != null && updateId != null) {
      update([selectedDate, oldSelectedDate, updateId]);
    } else {
      update();
    }
  }

  ///fuction to update Selected Date [mSelectedYear]
  void changeSelectedYear({
    required DateTime selectedYear,
    DateTime? oldSelectedYear,
    required String commonUpdateId,
    String? updateId,
    bool updateByID = false,
  }) {
    mSelectedYear = selectedYear;
    //common update Id for date changes
    update([commonUpdateId]);

    if (updateByID && oldSelectedYear != null && updateId != null) {
      update([selectedYear, oldSelectedYear, updateId]);
    } else {
      update();
    }
  }
}
