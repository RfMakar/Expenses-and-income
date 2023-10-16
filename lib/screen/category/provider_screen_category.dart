import 'package:budget/models/categories.dart';
import 'package:budget/models/operations.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/models/switch_date.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenCategory extends ChangeNotifier {
  ProviderScreenCategory(this.finance, this.switchDate, this.groupCategory);
  final int finance;
  final SwitchDate switchDate;
  final GroupCategory groupCategory;
  late SumOperation sumOperation;
  late List<GroupSubCategory> listGroupSubCategory;
  late List<HistoryOperation> listHistoryOperation;

  Future loadData() async {
    await getSumOperationCategory();
    await getListGroupSubCategory();
    await getListHistoryOperationCategory();
  }

  Future getSumOperationCategory() async {
    sumOperation = await DBFinance.getSumOperationCategoryInPeriod(
        switchDate, finance, groupCategory.id);
  }

  Future getListGroupSubCategory() async {
    listGroupSubCategory = await DBFinance.getListGroupSubCategoryInPeriod(
        switchDate, finance, groupCategory.id);
  }

  Future getListHistoryOperationCategory() async {
    //Если период месяц, то история операций будет, если год то не будет
    if (switchDate.state == 0) {
      listHistoryOperation = await DBFinance.getListHistoryOperationCategory(
          switchDate.getDateTime(), finance, groupCategory.id);
      for (var historyOperation in listHistoryOperation) {
        historyOperation.listOperation =
            await DBFinance.getListOperationCategory(
                DateTime.tryParse(historyOperation.date)!,
                finance,
                groupCategory.id);
      }
    } else if (switchDate.state == 1) {
      listHistoryOperation = [];
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
    return groupCategory.name;
  }

  String titleSumOperation() {
    return sumOperation.getValue(finance);
  }

  Color colorGroupSubCategory(int index) {
    return Color(int.parse(groupCategory.color));
  }

  String titleGroupSubCategory(int index) {
    return listGroupSubCategory[index].name;
  }

  double percentGroupSubCategory(int index) {
    return listGroupSubCategory[index].percent;
  }

  String valueGroupSubCategory(int index) {
    return listGroupSubCategory[index].getValue(finance);
  }

  GroupSubCategory groupSubCategory(int index) {
    return listGroupSubCategory[index];
  }
}
