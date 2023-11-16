/*
state = 0 -> период месяц
state = 1 -> период год
*/

class SwitchDate {
  var _dateTime = DateTime.now();
  var state = 0;

  DateTime getDateTime() {
    return _dateTime;
  }

  void switchState() {
    if (state == 1) {
      stateMonth();
    } else {
      stateYear();
    }
  }

  //Устанавльвается текущая дата и меняется период
  void stateYear() {
    _dateTime = DateTime.now();
    state = 1;
  }

  //Устанавльвается текущая дата и меняется период
  void stateMonth() {
    _dateTime = DateTime.now();
    state = 0;
  }

  //Переключает дату назад в зависимости от периода
  void backDate() {
    if (state == 0) {
      //Если месяц и год не 01.2021 то дата переключится на месяц назад
      var enabledButton = (_dateTime.year == 2021) && (_dateTime.month == 1);
      if (!enabledButton) {
        _dateTime = DateTime(_dateTime.year, _dateTime.month - 1);
      }
    } else if (state == 1) {
      //Если год 2021 то дата переключится на год назад
      var enabledButton = (_dateTime.year == 2021);
      if (!enabledButton) {
        _dateTime = DateTime(_dateTime.year - 1);
      }
    }
  }

  //Переключает дату вперед в зависимости от периода
  void nextDate() {
    final currentDate = DateTime.now();
    if (state == 0) {
      //Если дата не текущая то прибавить месяц
      final enabledButton = (_dateTime.year == currentDate.year) &&
          (_dateTime.month == currentDate.month);
      if (!enabledButton) {
        _dateTime = DateTime(
          _dateTime.year,
          _dateTime.month + 1,
        );
      }
    } else if (state == 1) {
      //Если год не текущий то прибавь год
      final enabledButton = (_dateTime.year == currentDate.year);
      if (!enabledButton) {
        _dateTime = DateTime(_dateTime.year + 1);
      }
    }
  }
}
