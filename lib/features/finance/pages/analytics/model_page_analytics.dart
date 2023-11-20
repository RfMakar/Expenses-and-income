import 'package:budget/repositories/finance/models/analitics.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:flutter/material.dart';

class ModelPageAnalytics extends ChangeNotifier {
  var _dateTime = DateTime.now();
  late List<AnaliticsByMonth> listAnaliticsByMonth;

  DateTime get dateTime => _dateTime;

  //Сумма расходов за месяц
  double totalExpencec() {
    var expenses = 0.0;
    for (var analiticsMonth in listAnaliticsByMonth) {
      expenses += analiticsMonth.expense;
    }
    return expenses;
  }

  //Сумма доходов за месяц
  double totalIncome() {
    var income = 0.0;
    for (var analiticsMonth in listAnaliticsByMonth) {
      income += analiticsMonth.income;
    }
    return income;
  }

  //Сумма итого за год
  double totalTotal() {
    var total = 0.0;
    for (var analiticsMonth in listAnaliticsByMonth) {
      total += analiticsMonth.total;
    }
    return total;
  }

  void onPressedButSwitchDateBack() {
    //Если год 2021 то дата переключится на год назад
    var enabledButton = (_dateTime.year == 2021);
    if (!enabledButton) {
      _dateTime = DateTime(_dateTime.year - 1);
    }
    listAnaliticsByMonth.clear;

    notifyListeners();
  }

  void onPressedButSwitchDateNext() {
    //Если год не текущий то прибавь год
    final enabledButton = (_dateTime.year == DateTime.now().year);
    if (!enabledButton) {
      _dateTime = DateTime(_dateTime.year + 1);
    }
    listAnaliticsByMonth.clear;

    notifyListeners();
  }

  Future<void> load() async {
    listAnaliticsByMonth = [];
    for (var i = 1; i <= 12; i++) {
      //Для каждого месяца получаем лист аналитики
      final listAnalitics =
          await DBFinance.getListAnaliticsByMonth(_dateTime.year, i);
      //Добавляем в listAnaliticsByMonth
      listAnaliticsByMonth.add(listAnalitics.first);
    }
  }
}
