import 'package:budget/model/category.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/screen2/const/db_table.dart';
import 'package:flutter/material.dart';

class ProviderScreenHome extends ChangeNotifier {
  var isSelectedBudget = [true, false];
  void sceenUpdate() {
    notifyListeners();
  }

  Future<List<Category>> getListFinance() {
    if (isSelectedBudget[0]) {
      return DBFinance.getListCategory(DBTable.expenses);
    } else {
      return DBFinance.getListCategory(DBTable.income);
    }
  }
}
