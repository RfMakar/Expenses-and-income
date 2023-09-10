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
  late double sumOperations;
  late List<HistoryOperation> listHistoryOperation;

  void updateScreen() {
    notifyListeners();
  }

  String titleAppBar() {
    return groupSubCategory.name;
  }

  String titleSumOperatin() {
    return finance == 0
        ? '-${sumOperations.toString()} ₽'
        : '+${sumOperations.toString()} ₽';
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
    return finance == 0
        ? '-${listHistoryOperation[index].value.toString()} ₽'
        : '+${listHistoryOperation[index].value.toString()} ₽';
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
    return finance == 0
        ? '-${listOperation(indexHistory)[indexOperation].value.toString()} ₽'
        : '+${listOperation(indexHistory)[indexOperation].value.toString()} ₽';
  }

  Future getSumOperationSubCategory() async {
    final list = await DBFinance.getListSumOperationSubCategory(
        dateTime, finance, groupSubCategory.id);

    sumOperations = list[0].value;
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
