import 'package:budget/repositories/finanse/models/operations.dart';
import 'package:budget/repositories/finanse/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuOperation extends ChangeNotifier {
  ProviderSheetMenuOperation(this.operation, this.finance);
  final Operation operation;
  final int finance;

  String titleSheet() {
    return '${operation.nameCategory} / ${operation.nameSubCategory}';
  }

  String subTitleSheet() {
    return 'Операция от ${operation.getDateFormat()}';
  }

  void onTapDeletedOperation() async {
    DBFinance.deleteOperation(operation);
  }
}
