import 'package:budget/repositories/finance/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenDataApp extends ChangeNotifier {
  Future<void> onTapDeleteAll() async {
    //Удалить всe категории, тем самым все данные
    await DBFinance.deleteTableCategory();
  }

  Future<void> onTapDeleteAllOperation() async {
    //Удалить все операции
    await DBFinance.deleteAllOperation();
  }
}
