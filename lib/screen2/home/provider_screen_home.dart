import 'package:budget/models/categories.dart';
import 'package:budget/models/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderScreenHome extends ChangeNotifier {
  var finance = 0; //0 - расходы, 1 - доходы
  var dateTime = DateTime.now();
  late double sumOperations;
  late List<HistoryOperation> listHistoryOperation;
  late List<GroupCategory> listGroupCategories;

  void screenUpdate() {
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

  String titleHistory(int index) {
    return listHistoryOperation[index].nameCategory;
  }

  String subtitleHistory(int index) {
    return listHistoryOperation[index].nameSubCategory;
  }

  String leadingHistory(int index) {
    return listHistoryOperation[index].id.toString();
  }

  String valueHistory(int index) {
    return listHistoryOperation[index].value.toString();
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

  Future getListHistoryOperation() async {
    final list = await DBFinance.getListOperationHistory(dateTime);

    listHistoryOperation = list;
  }

  Future getListGroupCategory() async {
    final list = await DBFinance.getListCategoryGroup(dateTime, finance);

    listGroupCategories = list;
  }

  Future getSumOperation() async {
    final list = await DBFinance.getListSumOperation(dateTime, finance);

    sumOperations = list[0].value;
  }
}
