import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';

class ModelDialogAddOperation {
  ModelDialogAddOperation(this._subCategory);
  final SubCategory _subCategory;
  var _dateTime = DateTime.now();

  String titleDialog() => _subCategory.name;
  DateTime dateTime() => _dateTime;

  void onChangedDate(DateTime newDateTime) {
    _dateTime = newDateTime;
  }

  void onPressedButtonAddOperation(String note, double value) {
    final writeOperation = WriteOperation(
      idSubcategory: _subCategory.id,
      date: _dateTime.toString(),
      year: _dateTime.year,
      month: _dateTime.month,
      day: _dateTime.day,
      note: note,
      value: value,
    );
    DBFinance.insertOperation(writeOperation);
  }
}
