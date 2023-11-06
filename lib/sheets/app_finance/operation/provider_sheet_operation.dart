import 'package:budget/repositories/finanse/models/operations.dart';
import 'package:flutter/widgets.dart';

class ProviderSheetOperation extends ChangeNotifier {
  ProviderSheetOperation(this.operation, this.finance);
  final Operation operation;
  final int finance;

  String titleSheet() {
    return operation.getValue(finance);
  }

  String subtitleSheet() {
    return 'Операция от ${operation.getDateFormat()}';
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
}
