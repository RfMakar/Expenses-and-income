import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:flutter/material.dart';

class ModelPageHistory extends ChangeNotifier {
  ModelPageHistory(this._finance);
  final Finance _finance;

  var _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;

  void updatePage() => notifyListeners();

  void onPressedButSwitchDateBack() {
    //Если месяц и год не 01.2021 то дата переключится на месяц назад
    var enabledButton = (_dateTime.year == 2021) && (_dateTime.month == 1);
    if (!enabledButton) {
      _dateTime = DateTime(_dateTime.year, _dateTime.month - 1);
    }
    notifyListeners();
  }

  void onPressedButSwitchDateNext() {
    //Если дата не текущая то прибавить месяц
    final enabledButton = (_dateTime.year == DateTime.now().year) &&
        (_dateTime.month == DateTime.now().month);
    if (!enabledButton) {
      _dateTime = DateTime(
        _dateTime.year,
        _dateTime.month + 1,
      );
    }
    notifyListeners();
  }

  Future<List<HistoryOperation>> getListHistoryOperationByMonth() async {
    var listHistoryOperation =
        await DBFinance.getListHistoryOperationByMonth(_finance, _dateTime);

    for (var historyOperation in listHistoryOperation) {
      historyOperation.listOperation = await DBFinance.getListOperationByMonth(
          DateTime.tryParse(historyOperation.date)!, _finance);
    }
    return listHistoryOperation;
  }
}
