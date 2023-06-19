import 'package:budget/model/category.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/screen2/const/db.dart';
import 'package:flutter/material.dart';

class ProviderScreenHome extends ChangeNotifier {
  var isSelectedSwitchExpInc = [true, false];
  var isSelectedSwitchDate = [false, true, false];
  var dateTime = DateTime.now();
  void screenUpdate() {
    notifyListeners();
  }

  //Переключает расход/доход
  void onPressedSwitchExpInc(List<bool> list) {}

  //Переключает дату
  void onPressedSwitchDate(List<bool> list, DateTime dateTime) {}

  Future<List<Category>> getListFinance() {
    return DBFinance.getListCategory(DBTable.expenses);
    // if (isSelectedSwitchExpInc[0]) {
    //   return DBFinance.getListCategory(DBTable.expenses);
    // } else {
    //   return DBFinance.getListCategory(DBTable.income);
    // }
  }
}
