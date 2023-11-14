import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/models/operations.dart';

class ModelSheetOperation {
  ModelSheetOperation(this._operation, this._finance);
  final Operation _operation;
  final Finance _finance;

  String titleSheet() {
    return _operation.getValue(_finance.id);
  }

  String titleDateTime() {
    return 'Операция от ${_operation.getDateFormat()}';
  }

  String titleCategoty() {
    return _operation.nameCategory;
  }

  String titleSubCategory() {
    return _operation.nameSubCategory;
  }

  String titleNote() {
    return _operation.getNote();
  }
}
