import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderWidgetCardCategory extends ChangeNotifier {
  ProviderWidgetCardCategory(this.category);
  final Category category;

  String nameCategories() {
    return category.name;
  }

  Color colorCategories() {
    return Color(int.parse(category.color));
  }

  String key() {
    return category.id.toString();
  }

  List<SubCategory> listNameSubcategories() {
    return category.listSubCategories!;
  }

  void updateWidget() async {
    await getListSubCategories();
    notifyListeners();
  }

  Future getListSubCategories() async {
    final listSubCategoties = await DBFinance.getListSubCategory(category);
    category.listSubCategories = listSubCategoties;
  }
}
