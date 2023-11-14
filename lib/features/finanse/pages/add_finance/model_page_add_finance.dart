import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:flutter/material.dart';

class ModelPageAddFinance extends ChangeNotifier {
  ModelPageAddFinance(this._finance);
  final Finance _finance;

  Future<List<Category>> getListCategory() async {
    return await DBFinance.getListCategory(_finance.id);
  }

  void updatePage() async {
    notifyListeners();
  }
}
