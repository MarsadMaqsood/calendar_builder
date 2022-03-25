import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../calendar_builder.dart';

///this controller is used to controll  the state of the [month_builder] ui
class MonthUiController extends GetxController {
  ///checking wether the yer picker is expanded or not
  bool isYearPickerExpanded = false;

  ///Page controller for Month
  late PageController mPageController;

  void Function(bool isExpanded)? onYearHeaderExpanded;
  void Function(DateTime selectedYear,bool isSelected)? onYearButtonClicked;
  void Function(OnDateSelected onDateSelected)? onDateClicked;

  ///used to chage the expanded or not-expanded , state of year picker
  void chageYearExpanded(
      {String? updateId,
      required String commonUpdateId,
      required bool isExpanded}) {
    ///if its aldready in the same state then it will  not update
    if (isYearPickerExpanded != isExpanded) {
      isYearPickerExpanded = isExpanded;

      ///common update Id for year picker expanded
      update([commonUpdateId]);
      if (updateId != null) {
        update([updateId]);
      } else {
        update();
      }
    }
  }

  ///checking for year dropdown should be expanded initially or not
  void expandInitiaally(bool isExpanded) {
    isYearPickerExpanded = isExpanded;
  }
}
