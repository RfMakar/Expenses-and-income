import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenDataApp extends ChangeNotifier {
  Future<void> onTapDeleteExpenses() async {
    //Удалить все расходы
  }

  Future<void> onTapDeleteIncome() async {
    //Удалить все доходы
  }

  Future<void> onTapDeleteAllData() async {
    //Удалить все операции
    await DBFinance.deleteAllOperation();
  }
}
