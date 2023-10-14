/*
state = 0 -> период месяц
state = 1 -> период год
*/

import 'package:intl/intl.dart';

class SwitchDate {
  var _dateTime = DateTime.now();
  var state = 0;

  String getDate() {
    return state == 0
        ? DateFormat.yMMMM().format(_dateTime)
        : DateFormat.y().format(_dateTime);
  }

  DateTime getDateTime() {
    return _dateTime;
  }

  void stateYear() {
    state = 1;
  }

  void stateMonth() {
    state = 0;
  }

  void backDate() {
    //Если месяц и год не 01.2021 то дата переключится на месяц назад
    var enabledButton = (_dateTime.year == 2021) && (_dateTime.month == 1);
    if (!enabledButton) {
      _dateTime = DateTime(
        _dateTime.year,
        _dateTime.month - 1,
      );
    }
  }

  void nextDate() {
    final currentDate = DateTime.now();
    //Если дата не текущая то прибавить месяц
    final enabledButton = (_dateTime.year == currentDate.year) &&
        (_dateTime.month == currentDate.month);
    if (!enabledButton) {
      _dateTime = DateTime(
        _dateTime.year,
        _dateTime.month + 1,
      );
    }
  }
}
