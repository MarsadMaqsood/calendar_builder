import 'package:calendar_builder/calendar_builder.dart';
import 'package:flutter/material.dart';

class MonthBuilderScreen extends StatelessWidget {
  const MonthBuilderScreen({Key? key}) : super(key: key);

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
                  endDate: DateTime(2026),
                  selectedDate: DateTime(2021, 3, 4),
                  selectedYear: DateTime(2021),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
