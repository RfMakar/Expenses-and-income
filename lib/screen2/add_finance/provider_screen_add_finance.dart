import 'package:budget/model/account.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/screen2/const/db.dart';
import 'package:flutter/material.dart';

class ProviderScreenAddFinance extends ChangeNotifier {
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  List<bool>? finance; //Расход_Доход

  final textEditingControllerValue = TextEditingController();

  DateTime get dateTime => _dateTime ?? DateTime.now();
  TimeOfDay get timeOfDay => _timeOfDay ?? TimeOfDay.now();

  late List<Account> listAccounts;

  void onTapAccount(int index) async {
    await DBFinance.rawUpdate(DBTableAccount.updateSelection0());
    await DBFinance.rawUpdate(
        DBTableAccount.updateSelection1(), [listAccounts[index].id!]);

    notifyListeners();
  }

  int selectionAccount(int index) {
    return listAccounts[index].selection;
  }

  Color colorAccount(int index) {
    return Color(int.parse(listAccounts[index].color));
  }

  String nameAccount(int index) {
    return listAccounts[index].name;
  }

  String valueAccount(int index) {
    return '${listAccounts[index].value} Р';
  }

  Future getListAccount() async {
    final maps = await DBFinance.rawQuery(DBTableAccount.getList());
    listAccounts =
        maps.isNotEmpty ? maps.map((e) => Account.fromMap(e)).toList() : [];
  }

  void updateScreen() async {
    await getListAccount();
    notifyListeners();
  }

  void onPressedSwitchExpInc(List<bool> list) {
    finance = list;
  }

  void onChangedDate(DateTime dateTime) {
    _dateTime = dateTime;
  }

  void onChangedTime(TimeOfDay timeOfDay) {
    _timeOfDay = timeOfDay;
  }
}
