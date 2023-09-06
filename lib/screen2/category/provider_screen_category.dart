import 'package:budget/models/categories.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenCategory extends ChangeNotifier {
  ProviderScreenCategory(this.finance, this.dateTime, this.groupCategory);
  final int finance;
  DateTime dateTime;
  final GroupCategory groupCategory;
  late double sumOperations;
  late List<GroupSubCategory> listGroupSubCategory;

  String titleAppBar() {
    return groupCategory.name;
  }

  String titleSumOperatin() {
    return '${sumOperations.toString()} ₽';
  }

  Color colorSumOperation() {
    return finance == 0 ? Colors.red : Colors.green;
  }

  //Переключает дату
  void onPressedSwitchDate(DateTime switchDateTime) {
    dateTime = switchDateTime;
    notifyListeners();
  }

  Color colorGroupSubCategory(int index) {
    return Color(int.parse(groupCategory.color));
  }

  String titleGroupSubCategory(int index) {
    return listGroupSubCategory[index].name;
  }

  double percentGroupSubCategory(int index) {
    return listGroupSubCategory[index].percent;
  }

  String valueGroupSubCategory(int index) {
    return finance == 0
        ? '-${listGroupSubCategory[index].value.toString()} ₽'
        : ' +${listGroupSubCategory[index].value.toString()} ₽';
  }

  Future getSumOperationCategory() async {
    final list = await DBFinance.getListSumOperationCategory(
        dateTime, finance, groupCategory.id);

    sumOperations = list[0].value;
  }

  Future getListGroupSubCategory() async {
    final list = await DBFinance.getListGroupSubCategory(
        dateTime, finance, groupCategory.id);
    listGroupSubCategory = list;
  }
}
