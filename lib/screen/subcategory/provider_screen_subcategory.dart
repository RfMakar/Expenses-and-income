import 'package:budget/models/operations.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderScreenSubCategory extends ChangeNotifier {
  ProviderScreenSubCategory(this.finance, this.dateTime, this.groupSubCategory);
  final int finance;
  DateTime dateTime;
  final GroupSubCategory groupSubCategory;
  late SumOperation sumOperation;
  late List<HistoryOperation> listHistoryOperation;

  void updateScreen() {
    notifyListeners();
  }

  String titleAppBar() {
    return groupSubCategory.name;
  }

  String titleSumOperation() {
    return sumOperation.getValue(finance);
  }

  //Переключает дату
  void onPressedSwitchDate(DateTime switchDateTime) {
    dateTime = switchDateTime;
    notifyListeners();
  }

  String titleHistoryOperation(int index) {
    final historyDay = DateTime.tryParse(listHistoryOperation[index].date)!.day;
    final curentDay = DateTime.now().day;

    if (curentDay == historyDay) {
      return 'Сегодня';
    } else if (curentDay - 1 == historyDay) {
      return 'Вчера';
    } else {
      return DateFormat.MMMMd()
          .format(DateTime.tryParse(listHistoryOperation[index].date)!);
    }
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

  Future loadData() async {
    await getSumOperationSubCategory();
    await getListHistoryOperationSubCategory();
  }

  Future getSumOperationSubCategory() async {
    final list = await DBFinance.getListSumOperationSubCategory(
        dateTime, finance, groupSubCategory.id);

    sumOperation = list[0];
  }

  Future getListHistoryOperationSubCategory() async {
    final list = await DBFinance.getListHistoryOperationSubCategory(
        dateTime, finance, groupSubCategory.id);
    for (var historyOperation in list) {
      historyOperation.listOperation =
          await DBFinance.getListOperationSubCategory(
              DateTime.tryParse(historyOperation.date)!,
              finance,
              groupSubCategory.id);
    }

    listHistoryOperation = list;
  }
}
