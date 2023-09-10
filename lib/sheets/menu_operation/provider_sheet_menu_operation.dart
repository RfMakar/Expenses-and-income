import 'package:budget/models/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ProviderSheetMenuOperation extends ChangeNotifier {
  ProviderSheetMenuOperation(this.operation, this.finance);
  final Operation operation;
  final int finance;

  String titleSheet() {
    return operation.getValue(finance);
  }

  String subtitleSheet() {
    final date = DateFormat.yMd().format(DateTime.tryParse(operation.date)!);
    final time = DateFormat.jm().format(DateTime.tryParse(operation.date)!);
    return '$date $time';
  }

  String titleCategoty() {
    return operation.nameCategory;
  }

  String titleSubCategory() {
    return operation.nameSubCategory;
  }

  String titleNote() {
    return operation.note == '' ? '-' : operation.note;
  }

  void onTapDeletedOperation() async {
    DBFinance.deleteOperation(operation);
  }
}
