import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenAddFinance extends ChangeNotifier {
  late List<Category> listCategory;
  late int finance;

  Category selectCategory(int index) {
    return listCategory[index];
  }

  Future getListCategory(int idFinance) async {
    finance = idFinance;
    listCategory = await DBFinance.getListCategory(finance);
  }

  void updateScreen() async {
    notifyListeners();
  }
}
