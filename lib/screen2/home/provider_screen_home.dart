import 'package:budget/const/db.dart';
import 'package:budget/model/history_operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderScreenHome extends ChangeNotifier {
  var isSelectedSwitchExpInc = [true, false];
  var isSelectedSwitchDate = [false, true, false];
  var dateTime = DateTime.now();
  late List<HistoryOperations> listHistoryOperations;
  void screenUpdate() {
    notifyListeners();
  }

  // String titleHistory(int index) {
  //   return DateFormat.MMMMd()
  //       .format(DateTime.parse(listHistoryOperations[index].date));
  // }
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
  void onPressedSwitchExpInc(List<bool> list) {}

  //Переключает дату
  void onPressedSwitchDate(DateTime dateTime) {}

  Future getListOperations() async {
    final maps = await DBFinance.rawQuery(
        DBTableHistoryOperations.getList(), [dateTime.year, dateTime.month]);
    final List<HistoryOperations> list = maps.isNotEmpty
        ? maps.map((e) => HistoryOperations.fromMap(e)).toList()
        : [];
    listHistoryOperations = list;
  }
}

/*
 final maps = await DBFinance.rawQuery(
        DBTableSubCategories.getList(), [categories.id]);
    final List<SubCategories> listSubCategoties = maps.isNotEmpty
        ? maps.map((e) => SubCategories.fromMap(e)).toList()
        : [];
    categories.listSubcategories = listSubCategoties;
*/