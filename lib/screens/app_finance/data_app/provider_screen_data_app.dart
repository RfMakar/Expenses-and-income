import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenDataApp extends ChangeNotifier {
  Future<void> onTapDeleteAll() async {
    //Удалить всё
    await DBFinance.deleteTableCategory();
    await DBFinance.deleteAllOperation();
  }

  Future<void> onTapDeleteAllOperation() async {
    //Удалить все операции
    await DBFinance.deleteAllOperation();
  }
}
