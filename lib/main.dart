import 'package:calendar_builder/src/models/cb_config.dart';
import 'package:calendar_builder/src/views/year_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_builder.dart';

void main() => runApp(const MyApp());

///Main root of this package
class MyApp extends StatelessWidget {
  ///constructor of root widget
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: CalendarHome(),
    );
  }
}

//TODO document confi class whcih supports hot reload
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
            child: Column(children: [
      // for (var item in colors)
      // SizedBox(
      //     height: 100, width: 100, child: ColoredBox(color: item)),

      Expanded(
          child: CbMonthBuilder(
        cbConfig: CbConfig(
          startDate: DateTime(2020),
          endDate: DateTime(2023),
          selectedDate: DateTime(2021),
          selectedYear: DateTime(2021),
          weekStartsFrom: WeekStartsFrom.friday,
          
        ),
      ))
    ])));
  }
}
