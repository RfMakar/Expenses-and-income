import 'package:budget/repositories/finanse/models/categories.dart';
import 'package:budget/repositories/finanse/models/operations.dart';
import 'package:budget/repositories/finanse/models/switch_date.dart';
import 'package:budget/repositories/finanse/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenFinance extends ChangeNotifier {
  ProviderScreenFinance(this.switchDate);
  late int finance;
  final SwitchDate switchDate;
  late SumOperation sumOperation;
  late List<GroupCategory> listGroupCategory;
  // late List<HistoryOperation> listHistoryOperation;

  Future loadData(int idFinance) async {
    finance = idFinance;
    await getSumAllOperation();
    await getListGroupCategory();
    // await getListHistoryAllOperation();
  }

  Future getSumAllOperation() async {
    sumOperation =
        await DBFinance.getSumAllOperationInPeriod(switchDate, finance);
  }

  Future getListGroupCategory() async {
    listGroupCategory =
        await DBFinance.getListGroupCategoryInPeriod(switchDate, finance);
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
