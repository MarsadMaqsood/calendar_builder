import '../utils/date_utils_cb.dart';

///Global configuration class for [calendar_builder]
class CbConfig {
  ///startDate of month
  final DateTime startDate;

  /// EndDate of month
  /// [endDate] should be greater than [startDate]
  final DateTime endDate;

  ///Current day/Todays Date
  ///default = now
  final DateTime? currentDay;

  ///Slected Date
  ///default = [startDate]
  final DateTime selectedDate;

  ///Slected Year
  ///default = [DateTime(StartDate.year)]
  final DateTime selectedYear;

  ///Add events
  final List<DateTime>? eventDates;

  ///Add disabled dates
  final List<DateTime>? disabledDates;

  ///Add hilighted dates
  final List<DateTime>? highlightedDates;

  ///weeek start from
  ///default = `WeekStartsFrom.sunday`
  ///
  ///------options---------
  ///
  /// `WeekStartsFrom.monday`
  ///
  /// `WeekStartsFrom.tuesday`
  ///
  /// `WeekStartsFrom.wednesday`
  ///
  /// `WeekStartsFrom.thursday`
  ///
  /// `WeekStartsFrom.friday`
  ///
  /// `WeekStartsFrom.saturday`
  ///
  /// `WeekStartsFrom.sunday`
  final WeekStartsFrom weekStartsFrom;

  ///
  CbConfig({
    required this.startDate,
    required this.endDate,
    required this.selectedDate,
    required this.selectedYear,
    this.currentDay,
    this.eventDates,
    this.disabledDates,
    this.highlightedDates,
    this.weekStartsFrom = WeekStartsFrom.sunday,
  })  : assert(startDate.isBefore(endDate),
            '\n\nERROR ( Calendar Builder ):\n---------\nInside CbConfig()\nEndDate Should be greater than StartDate\n---------\n_'),
        assert(
            DateUtilsCB.checkDayisSelected(
                  dateSelected: selectedDate,
                  loopedDay: endDate,
                ) ||
                selectedDate.isBefore(endDate),
            '\n\nERROR ( Calendar Builder ):\n---------\nInside CbConfig()\nSelectedDate Should be in B/w StartDate and EndDate\n---------\n_'),
        assert(
            DateUtilsCB.checkDayisSelected(
                  dateSelected: selectedDate,
                  loopedDay: startDate,
                ) ||
                selectedDate.isAfter(startDate),
            '\n\nERROR ( Calendar Builder ):\n---------\nInside CbConfig()\nSelectedDate Should be in B/w StartDate and EndDate\n---------\n_'),
        assert(selectedYear.year >= startDate.year &&
            selectedYear.year <= endDate.year);
}
