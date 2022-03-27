///calendar week start from [monday,....,saturday,sunday]
enum WeekStartsFrom {
  ///week starts from [monday]
  monday,

  ///
  tuesday,

  ///

  wednesday,

  ///

  thursday,

  ///

  friday,

  ///week starts from [saturday]
  saturday,

  ///week starts from [sunday]
  sunday,
}

///contails all the logic of this calendar_builder package
class DateUtilsCB {
  ///returns  all dates from  [startDate - endDate] in the form of List of DateTime
  static List<DateTime> getDaysInBeteween({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    List<DateTime> days = [];
    for (var i = 0; i <= (endDate.difference(startDate).inDays); i++) {
      days.add(
        DateTime(
          startDate.year,
          startDate.month,
          // In Dart you can set more than. 30 days, DateTime will do the trick
          startDate.day + i,
        ),
      );
    }
    return days;
  }

  ///this function return  all the dates in a year from  [startDate - endDate]
  ///if `endDate = DateTime(2021,3,3)`  this function will return dates till `endDate` as  `DateTime(2022).subtract(Duration`
  static List<DateTime> getAllDaysInBetweenYears({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    startDate = DateTime(startDate.year);

    endDate = DateTime(endDate.year + 1);

    List<DateTime> days = [];
    for (var i = 0; i <= (endDate.difference(startDate).inDays) - 1; i++) {
      days.add(DateTime(
        startDate.year,
        startDate.month,
        // In Dart you can set more than. 30 days, DateTime will do the trick
        startDate.day + i,
      ));
    }
    return days;
  }

  ///returns  all Years  from  [startDate - endDate] in the form of List of DateTime
  static List<DateTime> getYearsInBeteween({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    List<DateTime> years = [];
    for (int i = startDate.year; i <= endDate.year; i++) {
      years.add(DateTime(i));
    }
    return years;
  }

  ///Checking for [dateSelected] in [loopedDays]
  ///if it contains the same date
  ///then
  ///it returns true
  ///else
  ///returns false
  static bool checkDayisSelected({
    bool isDisabled = false,
    required DateTime dateSelected,
    required DateTime loopedDay,
  }) {
    if (!isDisabled) {
      return dateSelected.year == loopedDay.year &&
          dateSelected.month == loopedDay.month &&
          dateSelected.day == loopedDay.day;
    } else {
      return false;
    }
  }

  ///check year is selected
  static bool checkYearIsSelected({
    bool isDisabled = false,
    required DateTime dateSelected,
    required DateTime loopedDay,
  }) {
    if (!isDisabled) {
      return dateSelected.year == loopedDay.year;
    } else {
      return false;
    }
  }

  ///Checking for [date] in [listOfDates]
  ///if it contains the same date
  ///then
  ///it returns true
  ///else
  ///returns false
  static bool checkDayisDisabled(
      {required List<DateTime> listOfDates, required DateTime date}) {
    return !listOfDates.any((element) => (element.year == date.year &&
        element.month == date.month &&
        element.day == date.day));
  }

  ///checking [listOfDates] has matching [date] in it
  static bool checkListContainsDate(
      {required List<DateTime> listOfDates, required DateTime date}) {
    return listOfDates.any((element) => (element.year == date.year &&
        element.month == date.month &&
        element.day == date.day));
  }

  ///Checking for [date] in [listOfDates]
  ///if it contains the same year
  ///then
  ///it returns false
  ///else
  ///returns true
  static bool checkYearisDisabled(
      {required List<DateTime> listOfDates, required DateTime date}) {
    return !listOfDates.any((element) => (element.year == date.year));
  }

  ///!latest removed #1
  // ///This function will return all the DateTime in one year [yearDate]
  // static List<DateTime> getAllDatesIn1Year(
  //     {required DateTime yearDate, required List<DateTime> allDates}) {
  //   List<DateTime> dates =
  //       allDates.where((element) => element.year == yearDate.year).toList();

  //   return dates;
  // }

  ///If [selectedYear] is 2021 then this function will return all the dates of months in 2021 in the form of [List<Map<String, List<DateTime>>>]
  static List<Map<String, List<DateTime>>> getAllMonthsIn1Year(
      {required DateTime selectedYear}) {
    ///returns all the dates in a year
    ///!latest removed #1
    // List<DateTime> _listOfDatesInYear = getAllDatesIn1Year(
    //   yearDate: selectedYear,
    //   allDates: allDates,
    // );
    ///!replaced
    List<DateTime> _listOfDatesInYear = DateUtilsCB.getAllDaysInBetweenYears(
        startDate: DateTime(selectedYear.year),
        endDate:
            DateTime(selectedYear.year + 1).subtract(const Duration(days: 1)));

    ///genrating Dates in each months as List<DateTime>
    List<DateTime> _listOfJan = _listOfDatesInYear
        .where((element) => element.month == DateTime.january)
        .toList();
    List<DateTime> _listOfFeb = _listOfDatesInYear
        .where((element) => element.month == DateTime.february)
        .toList();
    List<DateTime> _listOfMarch = _listOfDatesInYear
        .where((element) => element.month == DateTime.march)
        .toList();
    List<DateTime> _listOfApril = _listOfDatesInYear
        .where((element) => element.month == DateTime.april)
        .toList();
    List<DateTime> _listOfMay = _listOfDatesInYear
        .where((element) => element.month == DateTime.may)
        .toList();
    List<DateTime> _listOfJune = _listOfDatesInYear
        .where((element) => element.month == DateTime.june)
        .toList();
    List<DateTime> _listOfJuly = _listOfDatesInYear
        .where((element) => element.month == DateTime.july)
        .toList();
    List<DateTime> _listOfAugust = _listOfDatesInYear
        .where((element) => element.month == DateTime.august)
        .toList();
    List<DateTime> _listOfSept = _listOfDatesInYear
        .where((element) => element.month == DateTime.september)
        .toList();
    List<DateTime> _listOfOct = _listOfDatesInYear
        .where((element) => element.month == DateTime.october)
        .toList();
    List<DateTime> _listOfNov = _listOfDatesInYear
        .where((element) => element.month == DateTime.november)
        .toList();
    List<DateTime> _listOfDec = _listOfDatesInYear
        .where((element) => element.month == DateTime.december)
        .toList();
    List<Map<String, List<DateTime>>> _months = [
      {'Jan': _listOfJan},
      {'Feb': _listOfFeb},
      {'March': _listOfMarch},
      {'April': _listOfApril},
      {'May': _listOfMay},
      {'June': _listOfJune},
      {'July': _listOfJuly},
      {'August': _listOfAugust},
      {'Sept': _listOfSept},
      {'Oct': _listOfOct},
      {'Nov': _listOfNov},
      {'Dec': _listOfDec},
    ];
    return _months;
  }

  ///This [getAll42DaysIn1Month] function will return all the 42 days in  a m
  static List<DateTime> getAll42DaysIn1Month({
    required List<DateTime> month,
    WeekStartsFrom weekStartsFrom = WeekStartsFrom.sunday,
  }) {
    List<DateTime> aMonthDaysList = month;
    DateTime firstDayOfaMonth = aMonthDaysList.first;

    ///For finding first Disabled Day
    late DateTime firstDisableDay;
    int weekSelectedIndex = (WeekStartsFrom.values.indexOf(weekStartsFrom) + 1);
    firstDisableDay = firstDayOfaMonth.subtract(
      ///Adding +7 to [firstDayOfaMonth.weekday]
      ///to avoid -ve result
      Duration(days: ((firstDayOfaMonth.weekday + 7) - weekSelectedIndex) % 7),
    );

    /* -----old-----
    // if (weekStartsFrom == WeekStartsFrom.monday) {
    //   ///Starts week with [Monday]
    //   firstDisableDay = firstDayOfaMonth
    //       .subtract(Duration(days: firstDayOfaMonth.weekday - 1));
    // } else if (weekStartsFrom == WeekStartsFrom.sunday) {
    //   ///Starts week with [Sunday]
    //   if (firstDayOfaMonth.weekday == 7) {
    //     firstDisableDay = firstDayOfaMonth;
    //   } else {
    //     firstDisableDay =
    //         firstDayOfaMonth.subtract(Duration(days: firstDayOfaMonth.weekday));
    //   }
    // } else if (weekStartsFrom == WeekStartsFrom.saturday) {
    //   ///Starts week with [Saturday]
    //   if (firstDayOfaMonth.weekday == 6) {
    //     firstDisableDay = firstDayOfaMonth;
    //   } else if (firstDayOfaMonth.weekday == 7) {
    //     firstDisableDay = firstDayOfaMonth.subtract(const Duration(days: 1));
    //   } else {
    //     firstDisableDay = firstDayOfaMonth
    //         .subtract(Duration(days: firstDayOfaMonth.weekday + 1));
    //   }
    // }
    */

    DateTime lastDayOfaMonth = aMonthDaysList.last;

    ///Algorithm to find Disabled Days
    List<DateTime> firstDisabledToLastDayOfMonth =
        getDaysInBeteween(startDate: firstDisableDay, endDate: lastDayOfaMonth);
    int lastlength = firstDisabledToLastDayOfMonth.length;
    int disabledDays = 42 - lastlength;

    ///not used
    // while (lastlength % 7 != 0) {
    //   lastlength++;
    //   disabledDays++;
    // }

    ///To find the last Disabled Days of the month
    DateTime lastDisabledDay =
        lastDayOfaMonth.add(Duration(days: disabledDays));

    ///!geting all 42 days
    List<DateTime> all42DaysOfMonth =
        getDaysInBeteween(startDate: firstDisableDay, endDate: lastDisabledDay);
    return all42DaysOfMonth;
  }
}
