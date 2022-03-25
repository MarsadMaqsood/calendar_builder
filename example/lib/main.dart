import 'dart:developer';

import 'package:calendar_builder/calendar_builder.dart';

import 'package:flutter/material.dart';

void main() {
  CalendarGlobals.showLogs = true;
  runApp(const MyApp());
}

///Main root of this package
class MyApp extends StatelessWidget {
  ///constructor of root widget
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(brightness: Brightness.dark),
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData.dark(),
      home: const CalendarHome(),
    );
  }
}

///Home class
class CalendarHome extends StatelessWidget {
  ///Home constructor
  const CalendarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CbMonthBuilder(
                  cbConfig: CbConfig(
                    startDate: DateTime(2020),
                    endDate: DateTime(2023),
                    selectedDate: DateTime(2021),
                    selectedYear: DateTime(2021),
                    weekStartsFrom: WeekStartsFrom.thursday,
                  ),
                  onYearHeaderExpanded: (isExp) {
                    log('isExpanded' + isExp.toString());
                  },
                  onDateClicked: (onDateClicked) {
                    log('selected date' +
                        onDateClicked.selectedDate.toString());
                    log('isSelected ' + onDateClicked.isSelected.toString());
                    log('isDisabled ' + onDateClicked.isDisabled.toString());
                  },
                  onYearButtonClicked: (year, isSelected) {
                    log('selected year' + year.toString());
                    log('isSelected ' + isSelected.toString());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
