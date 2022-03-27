import 'package:calendar_builder/calendar_builder.dart';
import 'package:example/custom_month_builder.dart';
import 'package:example/customized_month_builder.dart';
import 'package:example/month_builder.dart';

import 'package:flutter/material.dart';

void main() {
  CalendarGlobals.showLogs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar builder Demo',
      // theme: ThemeData(brightness: Brightness.dark),
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData.dark(),
      routes: {
        '/month_builder': (context) => const MonthBuilderScreen(),
        '/customized_month_builder': (context) =>
            const CustomizedMonthBuilderScreen(),
        '/custom_month_builder': (context) => const CustomMonthBuilderScreen(),
        // '/fromAsset': (context) => const PlayVideoFromAsset(),
        // '/fromNetwork': (context) => const PlayVideoFromNetwork(),
        // '/customVideo': (context) => const CustomVideoControlls(),
      },
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            // _button('Play video from File'),
            _button(
              'Default / Simple Month Builder',
              onPressed: () =>
                  Navigator.of(context).pushNamed('/month_builder'),
            ),
            _button(
              'Customized Month Builder',
              onPressed: () =>
                  Navigator.of(context).pushNamed('/customized_month_builder'),
            ),
            _button(
              'Custom Month Builder',
              onPressed: () =>
                  Navigator.of(context).pushNamed('/custom_month_builder'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(String text, {void Function()? onPressed}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: OutlinedButton(
          onPressed: onPressed ?? () {},
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
