import 'package:budget/models/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ProviderSheetMenuOperation extends ChangeNotifier {
  ProviderSheetMenuOperation(this.operation, this.finance);
  final Operation operation;
  final int finance;

  String titleSheet() {
    return operation.nameCategory;
  }

  String subtitleSheet() {
    return operation.nameSubCategory;
  }

  String note() {
    return operation.note;
  }

  String date() {
    return DateFormat.yMd().format(DateTime.tryParse(operation.date)!);
  }

  String time() {
    return DateFormat.jm().format(DateTime.tryParse(operation.date)!);
  }

  String trailingSheet() {
    return operation.value.toString();
  }

  void onTapDeletedOperation() async {
    DBFinance.deleteOperation(operation);
  }
}
