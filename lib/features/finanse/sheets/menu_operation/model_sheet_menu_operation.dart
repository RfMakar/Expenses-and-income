import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';

class ModelSheetMenuOperation {
  ModelSheetMenuOperation(this._operation);
  final Operation _operation;

  Operation operation() => _operation;

  String titleSheet() =>
      '${_operation.nameCategory} / ${_operation.nameSubCategory}';

  String subTitleSheet() => 'Операция от ${_operation.getDateFormat()}';

  void onTapDeletedOperation() {
    DBFinance.deleteOperation(_operation);
  }
}
