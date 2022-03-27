import 'package:flutter/material.dart';

///A global theme classs for all colors [Theme]
class CalendarGlobals {
  ///Minumum duration
  static const kMinDuration = Duration(milliseconds: 400);

  ///maximum duration
  static const kMaxDuration = Duration(milliseconds: 800);

  ///orange color
  static const Color kOrange = Color(0xffFF5917);

  ///list of months
  static const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  ///list of Weeks
  static const List<List<String>> weeksStarter = [
    [
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
    ],
    [
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
      'MON',
    ],
    [
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
      'MON',
      'TUE',
    ],
    [
      'THU',
      'FRI',
      'SAT',
      'SUN',
      'MON',
      'TUE',
      'WED',
    ],
    [
      'FRI',
      'SAT',
      'SUN',
      'MON',
      'TUE',
      'WED',
      'THU',
    ],
    [
      'SAT',
      'SUN',
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
    ],
    [
      'SUN',
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
    ],
  ];

  ///Enable or disable dev logs
  static bool showLogs = false;

  ///Enable or disable dev logs
  static void debugLogs(Object _log) {
    if (showLogs) debugPrint(_log.toString());
  }
}
