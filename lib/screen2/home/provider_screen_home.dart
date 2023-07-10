import 'package:budget/model/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenHome extends ChangeNotifier {
  var isSelectedSwitchExpInc = [true, false];
  var isSelectedSwitchDate = [false, true, false];
  var dateTime = DateTime.now();
  late List<Operations> listOperations;
  void screenUpdate() {
    notifyListeners();
  }

  //Переключает расход/доход
  void onPressedSwitchExpInc(List<bool> list) {}

  //Переключает дату
  void onPressedSwitchDate(List<bool> list, DateTime dateTime) {}

  // Future<List<Operations>> getListOperations() async{
  //   if (isSelectedSwitchExpInc[0]) {
  //     return  DBFinance.rawQuery('');
  //   } else {
  //     return DBFinance.rawQuery('');
  //   }
  // }
}
