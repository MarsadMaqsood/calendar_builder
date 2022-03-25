import 'package:flutter/material.dart';

///A global theme classs for all colors [Theme]
class CalendarGlobals {
  static const kMinDuration = Duration(milliseconds: 400);
  static const kMaxDuration = Duration(milliseconds: 800);
  static const Color kOrange = Color(0xffFF5917);
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
  static bool showLogs = false;
  static void debugLogs(Object _log) {
    if (showLogs) debugPrint(_log.toString());
  }
}
