import 'package:budget/const/db.dart';
import 'package:budget/models/group_categories.dart';
import 'package:budget/models/history_operations.dart';
import 'package:budget/models/sum_operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenHome extends ChangeNotifier {
  var finance = 0; //0 - расходы, 1 - доходы
  var dateTime = DateTime.now();
  late double sumOperations;
  late List<HistoryOperations> listHistoryOperations;
  late List<GroupCategories> listGroupCategories;

  void screenUpdate() {
    notifyListeners();
  }

  String titleSumOperations() {
    return finance == 0
        ? '- ${sumOperations.toString()}'
        : '+ ${sumOperations.toString()}';
  }

  Color colorSumOperations() {
    return finance == 0 ? Colors.red : Colors.green;
  }

  Color colorGroupCategories(int index) {
    return Color(int.parse(listGroupCategories[index].color));
  }

  String titleGroupCategories(int index) {
    return listGroupCategories[index].name;
  }

  double percentGroupCategories(int index) {
    return listGroupCategories[index].percent;
  }

  String valueGroupCategories(int index) {
    return listGroupCategories[index].value.toString();
  }

  String titleHistory(int index) {
    return listHistoryOperations[index].namecategories;
  }

  String subtitleHistory(int index) {
    return listHistoryOperations[index].namesubcategories;
  }

  String leadingHistory(int index) {
    return listHistoryOperations[index].idoperations.toString();
  }

  String valueHistory(int index) {
    return listHistoryOperations[index].value.toString();
  }

  //Переключает расход/доход
  void onPressedSwitchFinace(int switchFinance) {
    finance = switchFinance;
    notifyListeners();
  }

  //Переключает дату
  void onPressedSwitchDate(DateTime switchDateTime) {
    dateTime = switchDateTime;
    notifyListeners();
  }

  Future getListOperations() async {
    final maps = await DBFinance.rawQuery(
        DBTableHistoryOperations.getList(), [dateTime.year, dateTime.month]);
    final List<HistoryOperations> list = maps.isNotEmpty
        ? maps.map((e) => HistoryOperations.fromMap(e)).toList()
        : [];
    listHistoryOperations = list;
  }

  Future getListGroupCategories() async {
    final maps = await DBFinance.rawQuery(
      DBTableGroupCategories.getList(),
      [
        dateTime.year,
        dateTime.month,
        finance,
        dateTime.year,
        dateTime.month,
        finance,
      ],
    );
    final List<GroupCategories> list = maps.isNotEmpty
        ? maps.map((e) => GroupCategories.fromMap(e)).toList()
        : [];
    listGroupCategories = list;
  }

  Future getSumOperations() async {
    final maps = await DBFinance.rawQuery(
      DBTableSumOperations.getList(),
      [
        dateTime.year,
        dateTime.month,
        finance,
      ],
    );
    final List<SumOperations> list = maps.isNotEmpty
        ? maps.map((e) => SumOperations.fromMap(e)).toList()
        : [];
    sumOperations = list[0].value;
  }
}
