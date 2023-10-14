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

  void updateScreen() {
    notifyListeners();
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

  String titleHistoryOperation(int index) {
    return listHistoryOperation[index].getDateFormat();
  }

  String valueHistory(int index) {
    return listHistoryOperation[index].getValue(finance);
  }

  List<Operation> listOperation(int index) {
    return listHistoryOperation[index].listOperation ?? [];
  }

  Operation operation(int indexHistory, int indexOperation) {
    return listOperation(indexHistory)[indexOperation];
  }

  String titleOperation(int indexHistory, int indexOperation) {
    return listOperation(indexHistory)[indexOperation].nameCategory;
  }

  String subtitlegOperation(int indexHistory, int indexOperation) {
    return listOperation(indexHistory)[indexOperation].nameSubCategory;
  }

  String trailingOperation(int indexHistory, int indexOperation) {
    return listOperation(indexHistory)[indexOperation].getValue(finance);
  }

  GroupSubCategory groupSubCategory(int index) {
    return listGroupSubCategory[index];
  }

  Future loadData() async {
    await getSumOperationCategory();
    await getListGroupSubCategory();
    await getListHistoryOperationCategory();
  }

  Future getSumOperationCategory() async {
    final list = await DBFinance.getListSumOperationCategory(
        switchDate.getDateTime(), finance, groupCategory.id);

    sumOperation = list[0];
  }

  Future getListGroupSubCategory() async {
    final list = await DBFinance.getListGroupSubCategory(
        switchDate.getDateTime(), finance, groupCategory.id);
    listGroupSubCategory = list;
  }

  Future getListHistoryOperationCategory() async {
    final list = await DBFinance.getListHistoryOperationCategory(
        switchDate.getDateTime(), finance, groupCategory.id);
    for (var historyOperation in list) {
      historyOperation.listOperation = await DBFinance.getListOperationCategory(
          DateTime.tryParse(historyOperation.date)!, finance, groupCategory.id);
    }

    listHistoryOperation = list;
  }
}
