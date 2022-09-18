import 'package:budget/database/budget/db_budget.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/budget.dart';
import 'package:budget/screen/home/history/screen_history.dart';

class ModelScreenHome extends ChangeNotifier {
  final currentDate = DateTime.now();
  var dateTime = DateTime.now();
  var isSelectedDate = [false, true, false];
  var isSelectedBudget = [true, false];

  void onPressedButExpensesIncome(int index) {
    for (int i = 0; i < isSelectedBudget.length; i++) {
      if (index == i) {
        isSelectedBudget[i] = true;
      } else {
        isSelectedBudget[i] = false;
      }
    }
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

  void onPressedToggleButtons(int index) {
    for (int buttonIndex = 0;
        buttonIndex < isSelectedDate.length;
        buttonIndex++) {
      if (buttonIndex == index) {
        isSelectedDate[buttonIndex] = true;
        dateTime = DateTime.now();
      } else {
        isSelectedDate[buttonIndex] = false;
      }
    }

    notifyListeners();
  }

  void onPressedButtonDateBack() {
    if (isSelectedDate[0]) {
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
      var enabledButton = (dateTime.year == 2021) && (dateTime.month == 1);
      if (!enabledButton) {
        dateTime = DateTime(
          dateTime.year,
          dateTime.month - 1,
        );
        notifyListeners();
      }
    } else if (isSelectedDate[2]) {
      var enabledButton = dateTime.year == 2021;
      if (!enabledButton) {
        dateTime = DateTime(
          dateTime.year - 1,
        );
        notifyListeners();
      }
    }
  }

  void onPressedButtonDateNext() {
    if (isSelectedDate[0]) {
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
    if (isSelectedDate[0]) {
      return dateTime.day.toString().padLeft(2, '0');
    } else {
      return 'День';
    }
  }

  String getMonth() {
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

  String getYear() {
    return dateTime.year.toString();
  }

  Future<String> getSumTextFormat() {
    if (isSelectedBudget[0]) {
      return DBBudget.getSumToDate('exptab', dateTime, isSelectedDate);
    } else {
      return DBBudget.getSumToDate('inctab', dateTime, isSelectedDate);
    }
  }

  Future<List<Budget>> groupListBudget() {
    if (isSelectedBudget[0]) {
      return DBBudget.getListGroup('exptab', dateTime, isSelectedDate);
    } else {
      return DBBudget.getListGroup('inctab', dateTime, isSelectedDate);
    }
  }
}
