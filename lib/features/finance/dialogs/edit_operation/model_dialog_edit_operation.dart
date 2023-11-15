import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';

class ModelDialogEditOperation {
  ModelDialogEditOperation(this._operation) {
    _dateTime = DateTime.parse(_operation.date);
  }
  final Operation _operation;

  late DateTime _dateTime;

  String value() => _operation.value.toString();

  String note() => _operation.note;

  DateTime dateTime() => _dateTime;

  void onChangedDate(DateTime newDateTime) {
    _dateTime = newDateTime;
  }

  void onPressedButtonEditOperation(double newValue, String newNote) {
    DBFinance.updateOperation(_dateTime, newValue, newNote, _operation);
  }
}
