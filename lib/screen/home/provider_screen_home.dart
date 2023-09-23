import 'package:budget/models/categories.dart';
import 'package:budget/models/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderScreenHome extends ChangeNotifier {
  var dateTime = DateTime.now();
  late SumOperation sumOperation;
  late List<GroupCategory> listGroupCategory;
  late List<HistoryOperation> listHistoryOperation;
  var isSelectedFinance = [true, false];
  int get finance =>
      isSelectedFinance[0] == true ? 0 : 1; //0 - расходы, 1 - доходы

  //Переключает |расход||доход|
  void onPressedButFinance(int index) {
    for (int i = 0; i < isSelectedFinance.length; i++) {
      if (index == i) {
        isSelectedFinance[i] = true;
      } else {
        isSelectedFinance[i] = false;
      }
    }
    notifyListeners();
  }

  void updateScreen() {
    notifyListeners();
  }

  //Переключает дату
  void onPressedSwitchDate(DateTime switchDateTime) {
    dateTime = switchDateTime;
    notifyListeners();
  }

  String titleAppBar() {
    return 'Название';
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
