# calendar_builder

Fully customizable calendar package for flutter.
Also supports for disabling dates, highlighting dates and displaying events inside calendar.

## Features

- Fully customisable widgets
- Add Events
- Highlight dates
- Disable dates
- Starting week can be changed
- ✅ MonthBuilder
- [TODO] DayBuilder
- [TODO] WeekBuilder


|                                               Month Builder                                                |                                          Customised Month Builder                                          |
| :--------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------: |
| ![](https://user-images.githubusercontent.com/85326522/160266643-9802e763-cf66-43cb-880f-2f861e93c208.jpg) | ![](https://user-images.githubusercontent.com/85326522/160266640-9cb71c30-9354-42bc-8b99-06f7f33518f6.jpg) |

|                                            Custom Month Builder                                            |                                        Month Builder with callbacks                                        |
| :--------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------: |
| ![](https://user-images.githubusercontent.com/85326522/160266644-3d0b66ff-3ded-4f47-92a7-291cebc7957c.jpg) | ![](https://user-images.githubusercontent.com/85326522/160266642-9cb04737-7182-4f42-b7c1-dd0804f7aa03.jpg) |

---

![](https://user-images.githubusercontent.com/85326522/160261784-e1df931e-5e9a-475c-8bc9-a3957290de1e.gif)


## Installation


In your `pubspec.yaml` file within your Flutter Project:

```yaml
dependencies:
  calendar_builder: <latest_version>
```


## How to use


```dart
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
                  selectedDate: DateTime(2021,3,4),
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

```
![](https://user-images.githubusercontent.com/85326522/160261779-9b11b4df-24c7-48e4-b3b3-d56b3d36d0e5.gif)
## Customised Month Builder
----
### Output

---

![](https://user-images.githubusercontent.com/85326522/160266642-9cb04737-7182-4f42-b7c1-dd0804f7aa03.jpg)

### code

---

```dart
CbMonthBuilder(
      cbConfig: CbConfig(
          startDate: DateTime(2020),
          endDate: DateTime(2123),
          selectedDate: DateTime(2022, 3, 4),
          selectedYear: DateTime(2022),
          weekStartsFrom: WeekStartsFrom.wednesday,
          disabledDates: [
            DateTime(2022, 1, 7),
            DateTime(2022, 1, 9),
          ],
          eventDates: [
            DateTime(2022, 1, 2),
            DateTime(2022, 1, 2),
            DateTime(2022, 1, 3)
          ],
          highlightedDates: [
            DateTime(2022, 1, 6),
            DateTime(2022, 1, 3)
          ]),
      monthCustomizer: MonthCustomizer(
          padding: const EdgeInsets.all(20),
          monthHeaderCustomizer: MonthHeaderCustomizer(
            textStyle: const TextStyle(
              color: Colors.red,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          monthButtonCustomizer: MonthButtonCustomizer(
              currentDayColor: Colors.orange,
              borderStrokeWidth: 2,
              textStyleOnDisabled: const TextStyle(color: Colors.red),
              highlightedColor: const Color.fromARGB(255, 255, 174, 0)),
          monthWeekCustomizer: MonthWeekCustomizer(
              textStyle:
                  const TextStyle(color: Color.fromARGB(255, 255, 174, 0)))
          // monthWidth: 500,
          // monthHeight: 200
          ),
      yearDropDownCustomizer: YearDropDownCustomizer(
          yearButtonCustomizer: YearButtonCustomizer(
            borderColorOnSelected: Colors.red,
          ),
          yearHeaderCustomizer: YearHeaderCustomizer(
              titleTextStyle:
                  const TextStyle(color: Color.fromARGB(255, 255, 174, 0)))),
      onYearHeaderExpanded: (isExpanded) {
        print('isExpanded ' + isExpanded.toString());
      },
      onDateClicked: (onDateClicked) {
        print('selected date' +
            onDateClicked.selectedDate.toString() +
            '\n' +
            'isSelected ' +
            onDateClicked.isSelected.toString() +
            '\n' +
            'isHighlighted ' +
            onDateClicked.isHighlighted.toString() +
            '\n' +
            'hasEvent ' +
            onDateClicked.hasEvent.toString() +
            '\n' +
            'isCurrentDate ' +
            onDateClicked.isCurrentDate.toString() +
            '\n' +
            'isDisabled ' +
            onDateClicked.isDisabled.toString());
      },
      onYearButtonClicked: (year, isSelected) {
        print('selected year ' +
            year.toString() +
            '\n' +
            'isSelected ' +
            isSelected.toString());
      },
    )
```

## Custom Month Builder
---
### Output

---

![](https://user-images.githubusercontent.com/85326522/160266644-3d0b66ff-3ded-4f47-92a7-291cebc7957c.jpg)

### code

---

```dart

CbMonthBuilder(
      cbConfig: CbConfig(
          startDate: DateTime(2020),
          endDate: DateTime(2123),
          selectedDate: DateTime(2022),
          selectedYear: DateTime(2022),
          weekStartsFrom: WeekStartsFrom.sunday,
          eventDates: [
            DateTime(2022, 1, 2),
            DateTime(2022, 1, 2),
            DateTime(2022, 1, 3)
          ],
          highlightedDates: [
            DateTime(2022, 1, 6),
            DateTime(2022, 1, 3)
          ]),
      yearDropDownCustomizer: YearDropDownCustomizer(
        yearHeaderBuilder:
            (isYearPickerExpanded, selectedDate, selectedYear, year) {
          return Container(
            height: 40,
            color: Colors.yellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  year,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(!isYearPickerExpanded
                    ? Icons.arrow_drop_down_outlined
                    : Icons.arrow_drop_up_outlined)
              ],
            ),
          );
        },
      ),
      monthCustomizer: MonthCustomizer(
        montMinhHeight: 200,
        monthMinWidth: 450,
        padding: const EdgeInsets.all(20),
        monthHeaderBuilder: (month, headerHeight, headerWidth, paddingLeft) {
          return Container(
            color: Colors.grey[200],
            height: headerHeight,
            width: headerWidth,
            child: Padding(
              padding: EdgeInsets.only(left: paddingLeft),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  month,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
        monthWeekBuilder: (index, weeks, weekHeight, weekWidth) {
          return SizedBox(
            height: weekHeight,
            width: weekWidth,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red)),
                child: Align(
                  child: Text(
                    weeks,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          );
        },
        monthButtonBuilder: (dateTime, childHeight, childWidth, isSelected,
            isDisabled, hasEvent, isHighlighted, isCurrentDay) {
          //Text Theme
          final txtTheme = Theme.of(context).textTheme;
          //color theme
          final colorTheme = Theme.of(context);

          var daysText = Align(
            child: Text(
              '${dateTime.day}',
              style: isDisabled
                  ? txtTheme.caption
                  : isSelected
                      ? txtTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorTheme.brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white)
                      : isHighlighted
                          ? txtTheme.bodyText2 //Highlighted TextStyle
                          : isCurrentDay
                              ? txtTheme.bodyText2 //CurrentDay TextStyle
                              : txtTheme.bodyText2,
            ),
          );
          if (isSelected) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.rectangle,
              ),
              margin: const EdgeInsets.all(2),
              child: daysText,
            );
          }
          return Container(
            decoration: BoxDecoration(
                color: isDisabled ? Colors.grey[200] : Colors.yellow,
                shape: BoxShape.rectangle,
                border: hasEvent || isHighlighted
                    ? Border.all(
                        color: isHighlighted ? Colors.red : Colors.blue,
                        width: 2)
                    : null),
            margin: const EdgeInsets.all(2),
            child: daysText,
          );
        },
      ),
    )

```
