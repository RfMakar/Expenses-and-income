import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';

class ModelSheetMenuOperation {
  ModelSheetMenuOperation(this._operation);
  final Operation _operation;

  Operation operation() => _operation;

  String titleSheet() =>
      '${_operation.nameCategory} / ${_operation.nameSubCategory}';

  DateTime dateTime() => DateTime.tryParse(_operation.date)!;

  void onTapDeletedOperation() {
    DBFinance.deleteOperation(_operation);
  }
}
