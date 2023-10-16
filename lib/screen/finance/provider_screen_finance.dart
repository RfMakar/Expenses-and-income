import 'package:budget/models/categories.dart';
import 'package:budget/models/operations.dart';
import 'package:budget/models/switch_date.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenFinance extends ChangeNotifier {
  ProviderScreenFinance(this.switchDate);
  late int finance;
  final SwitchDate switchDate;
  late SumOperation sumOperation;
  late List<GroupCategory> listGroupCategory;
  late List<HistoryOperation> listHistoryOperation;

  Future loadData(int idFinance) async {
    finance = idFinance;
    await getSumAllOperation();
    await getListGroupCategory();
    await getListHistoryAllOperation();
  }

  Future getSumAllOperation() async {
    sumOperation =
        await DBFinance.getSumAllOperationInPeriod(switchDate, finance);
  }

  Future getListGroupCategory() async {
    listGroupCategory =
        await DBFinance.getListGroupCategoryInPeriod(switchDate, finance);
  }

  Future getListHistoryAllOperation() async {
    //Если период месяц, то история операций будет, если год то не будет
    if (switchDate.state == 0) {
      listHistoryOperation = await DBFinance.getListHistoryAllOperation(
          switchDate.getDateTime(), finance);
      for (var historyOperation in listHistoryOperation) {
        historyOperation.listOperation = await DBFinance.getListAllOperation(
            DateTime.tryParse(historyOperation.date)!, finance);
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

  void updateScreen() async {
    notifyListeners();
  }

  String titleSumOperation() {
    return sumOperation.getValue(finance);
  }

  Color colorGroupCategory(int index) {
    return Color(int.parse(listGroupCategory[index].color));
  }

  String titleGroupCategory(int index) {
    return listGroupCategory[index].name;
  }

  double percentGroupCategory(int index) {
    return listGroupCategory[index].percent;
  }

  String valueGroupCategory(int index) {
    return listGroupCategory[index].getValue(finance);
  }

  GroupCategory groupCategory(int index) {
    return listGroupCategory[index];
  }
}
