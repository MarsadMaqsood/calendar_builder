import 'package:calendar_builder/src/utils/date_utils_cb.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateUtilsCB Testing', () {
    final DateTime startDate = DateTime(DateTime.now().year);
    final DateTime endDate =
        DateTime(DateTime.now().year + 20).subtract(const Duration(days: 1));
    final selectedDate = DateTime.now();
    final notSelectedDate = selectedDate.add(const Duration(days: 1));
    final List<DateTime> listOfDates = [
      selectedDate,
      notSelectedDate,
      startDate,
      endDate
    ];

    ///
    DateTime _year = DateTime.now();
    List<Map<String, List<DateTime>>> monthsInaYear =
        DateUtilsCB.getAllMonthsIn1Year(selectedYear: _year);

    ///!getDaysInBeteween Test
    test('getDaysInBeteween', () {
      List<DateTime> startToEndDates =
          DateUtilsCB.getDaysInBeteween(startDate: startDate, endDate: endDate);

      expect(startToEndDates.first, startDate);
      expect(startToEndDates.last, endDate);
    });

    ///!getAllDaysInBetweenYears Test
    test('getAllDaysInBetweenYears', () {
      List<DateTime> allStartToEndDates = DateUtilsCB.getAllDaysInBetweenYears(
          startDate: startDate, endDate: endDate);

      expect(allStartToEndDates.first, startDate);
      expect(allStartToEndDates.last, endDate);
    });

    ///!getYearsInBeteween Test
    test('getYearsInBeteween', () {
      List<DateTime> allYears = DateUtilsCB.getYearsInBeteween(
          startDate: startDate, endDate: endDate);
      expect(allYears.first, startDate);
      expect(allYears.last, DateTime(endDate.year));
    });

    ///!checkDayisSelected Test
    test('checkDayisSelected', () {
      ///
      bool checkIsSelected(DateTime dateSelected) {
        return DateUtilsCB.checkDayisSelected(
            dateSelected: dateSelected, loopedDay: selectedDate);
      }

      expect(checkIsSelected(selectedDate), true);
      expect(checkIsSelected(notSelectedDate), false);
    });

    ///!checkDayisDisabled Test
    test('checkDayisDisabled', () {
      ///
      bool checkIsDisabled(DateTime disabled) {
        return DateUtilsCB.checkDayisDisabled(
            listOfDates: listOfDates, date: disabled);
      }

      expect(checkIsDisabled(selectedDate), false);
      expect(checkIsDisabled(DateTime(300)), true);
    });

    ///!checkListContainsDate Test
    test('checkListContainsDate', () {
      ///
      bool checkContains(DateTime contains) {
        return DateUtilsCB.checkListContainsDate(
            listOfDates: listOfDates, date: contains);
      }

      expect(checkContains(selectedDate), true);
      expect(checkContains(DateTime(300)), false);
    });

    ///!checkYearisDisabled Test
    test('checkYearisDisabled', () {
      ///
      bool checkYearDisabled(DateTime disabled) {
        return DateUtilsCB.checkYearisDisabled(
            listOfDates: listOfDates, date: disabled);
      }

      expect(checkYearDisabled(selectedDate), false);
      expect(checkYearDisabled(DateTime(300)), true);
    });

    ///!getAllMonthsIn1Year Test
    test('getAllMonthsIn1Year', () {
      expect(monthsInaYear.length, 12);

      ///Checks for first month day (ie, Jan-1) is equal to  `DateTime(_year.year)` this date or not
      expect(monthsInaYear.first.values.first.first, DateTime(_year.year));

      ///Checks for last month, last day (ie, Dec-30/31) is equal to  `DateTime(_year.year + 1).subtract(const Duration(days: 1))` this date or not
      expect(monthsInaYear.last.values.last.last,
          DateTime(_year.year + 1).subtract(const Duration(days: 1)));
    });

    ///!getAll42DaysIn1Month Test
    test('getAll42DaysIn1Month', () {
      final List<DateTime> oneMonth = DateUtilsCB.getAll42DaysIn1Month(
          month: monthsInaYear.first.values.first);
      expect(oneMonth.length, 42);
    });
  });
}
