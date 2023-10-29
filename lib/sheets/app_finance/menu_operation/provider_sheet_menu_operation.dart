import 'package:budget/models/app_finance/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/widgets.dart';

class ProviderSheetMenuOperation extends ChangeNotifier {
  ProviderSheetMenuOperation(this.operation, this.finance);
  final Operation operation;
  final int finance;

  String titleSheet() {
    return operation.getValue(finance);
  }

  String subtitleSheet() {
    return operation.getDateFormat();
  }

  String titleCategoty() {
    return operation.nameCategory;
  }

  String titleSubCategory() {
    return operation.nameSubCategory;
  }

  String titleNote() {
    return operation.getNote();
  }

  void onTapDeletedOperation() async {
    DBFinance.deleteOperation(operation);
  }
}
