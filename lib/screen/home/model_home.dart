import 'package:budget/database/budget/db_budget.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/budget.dart';
import 'package:budget/screen/home/history/screen_history.dart';

class ModelScreenHome extends ChangeNotifier {
  final currentDate = DateTime.now(); // Для onPressedButtonDateNext
  var dateTime = DateTime.now(); //Текущая дата
  var isSelectedDate = [false, true, false];
  var isSelectedBudget = [true, false];

  //Переключает ToggleButtons |расход||доход|
  void onPressedButExpensesIncome(int index) {
    for (int i = 0; i < isSelectedBudget.length; i++) {
      if (index == i) {
        isSelectedBudget[i] = true;
      } else {
        isSelectedBudget[i] = false;
      }
    }
    //Устанавливает текущию дату после переключения ToggleButtons
    dateTime = DateTime.now();
    notifyListeners();
  }

  void onTapListTile(BuildContext context, Budget budget) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenHistory(
          nameCategory: budget.category!,
          dateTime: dateTime,
          isSelected: isSelectedDate,
          isSelectedBudget: isSelectedBudget,
        ),
      ),
    );
    notifyListeners();
  }

//Переключает ToggleButtons |день||месяц|год|
  void onPressedToggleButtons(int index) {
    for (int buttonIndex = 0;
        buttonIndex < isSelectedDate.length;
        buttonIndex++) {
      if (buttonIndex == index) {
        isSelectedDate[buttonIndex] = true;
        //Если нажать повторно, то дата сбросится на текущую
        dateTime = DateTime.now();
      } else {
        isSelectedDate[buttonIndex] = false;
      }
    }
    notifyListeners();
  }

  //Переключение даты назад
  void onPressedButtonDateBack() {
    //В зависимости он нажатой ToggleButtons изменяется число, месяц или год
    if (isSelectedDate[0]) {
      //Если число, месяц и год не 01.01.2021(Минимальная дата в проекте) то дата переключится на день назад
      var enabledButton = (dateTime.year == 2021) &&
          (dateTime.month == 1) &&
          (dateTime.day == 1);
      if (!enabledButton) {
        dateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day - 1,
        );
        notifyListeners();
      }
    } else if (isSelectedDate[1]) {
      //Если месяц и год не 01.2021 то дата переключится на месяц назад
      var enabledButton = (dateTime.year == 2021) && (dateTime.month == 1);
      if (!enabledButton) {
        dateTime = DateTime(
          dateTime.year,
          dateTime.month - 1,
        );
        notifyListeners();
      }
    } else if (isSelectedDate[2]) {
      //Если год не 2021 то дата переключится на год назад
      var enabledButton = dateTime.year == 2021;
      if (!enabledButton) {
        dateTime = DateTime(
          dateTime.year - 1,
        );
        notifyListeners();
      }
    }
  }

//Переключение даты вперед
  void onPressedButtonDateNext() {
    //В зависимости он нажатой ToggleButtons изменяется число, месяц или год
    if (isSelectedDate[0]) {
      //Если дата не текущая то прибавить день
      var enabledButton = (dateTime.year == currentDate.year) &&
          (dateTime.month == currentDate.month) &&
          (dateTime.day == currentDate.day);
      if (!enabledButton) {
        dateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day + 1,
        );
        notifyListeners();
      }
    } else if (isSelectedDate[1]) {
      //Если дата не текущая то прибавить месяц
      var enabledButton = (dateTime.year == currentDate.year) &&
          (dateTime.month == currentDate.month);
      if (!enabledButton) {
        dateTime = DateTime(
          dateTime.year,
          dateTime.month + 1,
        );
        notifyListeners();
      }
    } else if (isSelectedDate[2]) {
      //Если дата не текущая то прибавить год
      var enabledButton = dateTime.year == currentDate.year;
      if (!enabledButton) {
        dateTime = DateTime(
          dateTime.year + 1,
        );
        notifyListeners();
      }
    }
  }

  String getDay() {
    //Если выбрана кнопка день, то вернуть текущий день
    if (isSelectedDate[0]) {
      return dateTime.day.toString().padLeft(2, '0');
    } else {
      return 'День';
    }
  }

  String getMonth() {
    //Если выбрана кнопка месяц, то вернуть текущий месяц
    if (isSelectedDate[0] || isSelectedDate[1]) {
      switch (dateTime.month) {
        case 1:
          return 'Январь';
        case 2:
          return 'Февраль';
        case 3:
          return 'Март';
        case 4:
          return 'Апрель';
        case 5:
          return 'Май';
        case 6:
          return 'Июнь';
        case 7:
          return 'Июль';
        case 8:
          return 'Август';
        case 9:
          return 'Сентябрь';
        case 10:
          return 'Октябрь';
        case 11:
          return 'Ноябрь';
        case 12:
          return 'Декабрь';
        default:
          return '';
      }
    } else {
      return 'Месяц';
    }
  }

  //Возврат текущего года
  String getYear() {
    return dateTime.year.toString();
  }

  //Возращает сумма расхода или дохода в зависимости от даты
  Future<String> getSumTextFormat() {
    if (isSelectedBudget[0]) {
      return DBBudget.getSumToDate('exptab', dateTime, isSelectedDate);
    } else {
      return DBBudget.getSumToDate('inctab', dateTime, isSelectedDate);
    }
  }

  //Возращает список лиюо расходов либо доходов в зависомости от даты
  Future<List<Budget>> groupListBudget() {
    if (isSelectedBudget[0]) {
      return DBBudget.getListGroup('exptab', dateTime, isSelectedDate);
    } else {
      return DBBudget.getListGroup('inctab', dateTime, isSelectedDate);
    }
  }
}
