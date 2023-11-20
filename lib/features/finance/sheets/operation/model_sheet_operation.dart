import 'package:budget/repositories/finance/models/operations.dart';

class ModelSheetOperation {
  ModelSheetOperation(this._operation);
  final Operation _operation;

  double titleSheet() {
    return _operation.value;
  }

  DateTime dateTime() => DateTime.tryParse(_operation.date)!;

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
