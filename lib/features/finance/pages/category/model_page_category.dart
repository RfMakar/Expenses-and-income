import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/models/switch_date.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:flutter/material.dart';

class ModelPageCategory extends ChangeNotifier {
  ModelPageCategory(this._finance, this._switchDate, this._groupCategory);
  final Finance _finance;
  final SwitchDate _switchDate;
  final GroupCategory _groupCategory;
  late SumOperation _sumOperation;
  late List<GroupSubCategory> listGroupSubCategory;

  Future getSumOperationCategory() async {
    _sumOperation = await DBFinance.getSumOperationCategoryInPeriod(
        _switchDate, _finance.id, _groupCategory.id);
  }

  Future getListGroupSubCategory() async {
    listGroupSubCategory = await DBFinance.getListGroupSubCategoryInPeriod(
        _switchDate, _finance.id, _groupCategory.id);
  }

  void updatePage() => notifyListeners();

  String titleAppBar() => _groupCategory.name;

  double titleSumOperation() => _sumOperation.value;

  Color colorGroupSubCategory(int index) =>
      Color(int.parse(_groupCategory.color));

  String titleGroupSubCategory(int index) => listGroupSubCategory[index].name;

  double percentGroupSubCategory(int index) =>
      listGroupSubCategory[index].percent;

  double valueGroupSubCategory(int index) => listGroupSubCategory[index].value;

  GroupSubCategory groupSubCategory(int index) => listGroupSubCategory[index];
}
