import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/models/switch_date.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:flutter/material.dart';

class ModelPageFinance extends ChangeNotifier {
  ModelPageFinance(this._finance, this._switchDate);
  final Finance _finance;
  final SwitchDate _switchDate;
  late SumOperation _sumOperation;
  late List<GroupCategory> listGroupCategory;

  Future getSumAllOperation() async {
    _sumOperation =
        await DBFinance.getSumAllOperationInPeriod(_switchDate, _finance.id);
  }

  Future getListGroupCategory() async {
    listGroupCategory =
        await DBFinance.getListGroupCategoryInPeriod(_switchDate, _finance.id);
  }

  void updatePage() => notifyListeners();

  // String titleDateTime() => _switchDate.getDate();
  String titleSumOperation() => _sumOperation.getValue(_finance.id);

  Color colorGroupCategory(int index) =>
      Color(int.parse(listGroupCategory[index].color));

  String titleGroupCategory(int index) => listGroupCategory[index].name;

  double percentGroupCategory(int index) => listGroupCategory[index].percent;

  String valueGroupCategory(int index) =>
      listGroupCategory[index].getValue(_finance.id);

  GroupCategory groupCategory(int index) => listGroupCategory[index];
}
