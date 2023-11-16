import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/models/switch_date.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:flutter/material.dart';

class ModelPageSubCategory extends ChangeNotifier {
  ModelPageSubCategory(this._finance, this._switchDate, this._groupSubCategory);
  final Finance _finance;
  final SwitchDate _switchDate;
  final GroupSubCategory _groupSubCategory;
  late SumOperation _sumOperation;
  late List<HistoryOperation> listHistoryOperation;

  void updatePage() => notifyListeners();

  Future getSumOperationSubCategory() async {
    _sumOperation = await DBFinance.getSumOperationSubCategoryInPeriod(
        _switchDate, _finance.id, _groupSubCategory.id);
  }

  Future getListHistoryOperationSubCategory() async {
    listHistoryOperation = await DBFinance.getListHistoryOperationSubCategory(
      _switchDate,
      _switchDate.getDateTime(),
      _finance.id,
      _groupSubCategory.id,
    );
    for (var historyOperation in listHistoryOperation) {
      historyOperation.listOperation =
          await DBFinance.getListOperationSubCategory(
              DateTime.tryParse(historyOperation.date)!,
              _finance.id,
              _groupSubCategory.id);
    }
  }

  String titleAppBar() => _groupSubCategory.name;

  String titleSumOperation() => _sumOperation.getValue(_finance.id);

  // String titleDateTime() => _switchDate.getDate();
}
