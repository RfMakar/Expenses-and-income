import 'package:budget/models/operations.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/models/switch_date.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenSubCategory extends ChangeNotifier {
  ProviderScreenSubCategory(
      this.finance, this.switchDate, this.groupSubCategory);
  final int finance;
  final SwitchDate switchDate;
  final GroupSubCategory groupSubCategory;
  late SumOperation sumOperation;
  late List<HistoryOperation> listHistoryOperation;
  Future loadData() async {
    await getSumOperationSubCategory();
    await getListHistoryOperationSubCategory();
  }

  Future getSumOperationSubCategory() async {
    sumOperation = await DBFinance.getSumOperationSubCategoryInPeriod(
        switchDate, finance, groupSubCategory.id);
  }

  Future getListHistoryOperationSubCategory() async {
    listHistoryOperation = await DBFinance.getListHistoryOperationSubCategory(
      switchDate,
      switchDate.getDateTime(),
      finance,
      groupSubCategory.id,
    );
    for (var historyOperation in listHistoryOperation) {
      historyOperation.listOperation =
          await DBFinance.getListOperationSubCategory(
              DateTime.tryParse(historyOperation.date)!,
              finance,
              groupSubCategory.id);
    }
  }

  void onPressedButBackDate() {
    switchDate.backDate();
    notifyListeners();
  }

  void onPressedButNextDate() {
    switchDate.nextDate();
    notifyListeners();
  }

  String titleAppBar() {
    return groupSubCategory.name;
  }

  String titleSumOperation() {
    return sumOperation.getValue(finance);
  }
}
