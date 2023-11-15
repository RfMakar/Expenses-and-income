import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:flutter/material.dart';

class ModelWidgetCardCategory extends ChangeNotifier {
  ModelWidgetCardCategory(this._category);
  final Category _category;

  Category category() => _category;

  String titleCard() => _category.name;

  String key() => _category.id.toString();

  int colorCatgory() => int.parse(_category.color);

  void updateWidget() {
    notifyListeners();
  }

  Future<List<SubCategory>> loadListSubCategory() async {
    return await DBFinance.getListSubCategory(_category);
  }
}
