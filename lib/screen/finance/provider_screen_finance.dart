import 'package:budget/models/categories.dart';
import 'package:budget/models/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenFinance extends ChangeNotifier {
  late int finance;
  var dateTime = DateTime.now();
  late SumOperation sumOperation;
  late List<GroupCategory> listGroupCategory;
  late List<HistoryOperation> listHistoryOperation;

  void updateScreen() async {
    notifyListeners();
  }

  //Переключает дату
  void onPressedSwitchDate(DateTime switchDateTime) {
    dateTime = switchDateTime;
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

  Future loadData(int idfinance) async {
    finance = idfinance;
    await getSumAllOperation();
    await getListGroupCategory();
    await getListHistoryAllOperation();
  }

  Future getSumAllOperation() async {
    final list = await DBFinance.getListSumAllOperation(dateTime, finance);

    sumOperation = list[0];
  }

  Future getListGroupCategory() async {
    final list = await DBFinance.getListGroupCategory(dateTime, finance);

    listGroupCategory = list;
  }

  Future getListHistoryAllOperation() async {
    final list = await DBFinance.getListHistoryAllOperation(dateTime, finance);
    for (var historyOperation in list) {
      historyOperation.listOperation = await DBFinance.getListAllOperation(
          DateTime.tryParse(historyOperation.date)!, finance);
    }

    listHistoryOperation = list;
  }
}
