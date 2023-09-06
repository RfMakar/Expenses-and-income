import 'package:budget/models/categories.dart';
import 'package:budget/models/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderScreenHome extends ChangeNotifier {
  var finance = 0; //0 - расходы, 1 - доходы
  var dateTime = DateTime.now();
  late double sumOperations;
  late List<GroupCategory> listGroupCategories;
  late List<HistoryOperation> listHistoryOperation;

  void updateScreen() {
    notifyListeners();
  }

  //Переключает расход/доход
  void onPressedSwitchFinance(int switchFinance) {
    finance = switchFinance;
    notifyListeners();
  }

  //Переключает дату
  void onPressedSwitchDate(DateTime switchDateTime) {
    dateTime = switchDateTime;
    notifyListeners();
  }

  String titleAppBar() {
    return finance == 0
        ? 'Расходы за ${DateFormat.MMMM().format(dateTime)}'
        : 'Доходы за ${DateFormat.MMMM().format(dateTime)}';
  }

  String titleSumOperatin() {
    return finance == 0
        ? '- ${sumOperations.toString()}'
        : '+ ${sumOperations.toString()}';
  }

  Color colorSumOperation() {
    return finance == 0 ? Colors.red : Colors.green;
  }

  Color colorGroupCategory(int index) {
    return Color(int.parse(listGroupCategories[index].color));
  }

  String titleGroupCategory(int index) {
    return listGroupCategories[index].name;
  }

  double percentGroupCategory(int index) {
    return listGroupCategories[index].percent;
  }

  String valueGroupCategory(int index) {
    return listGroupCategories[index].value.toString();
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
        ? '- ${listHistoryOperation[index].value.toString()}'
        : '+ ${listHistoryOperation[index].value.toString()}';
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
    return listOperation(indexHistory)[indexOperation].value.toString();
  }

  Future getSumOperation() async {
    final list = await DBFinance.getListSumOperation(dateTime, finance);

    sumOperations = list[0].value;
  }

  Future getListGroupCategory() async {
    final list = await DBFinance.getListCategoryGroup(dateTime, finance);

    listGroupCategories = list;
  }

  Future getListHistoryOperation() async {
    final list = await DBFinance.getListHistoryOperation(dateTime, finance);
    for (var historyOperation in list) {
      historyOperation.listOperation = await DBFinance.getListOperation(
          DateTime.tryParse(historyOperation.date)!, finance);
    }

    listHistoryOperation = list;
  }
}
