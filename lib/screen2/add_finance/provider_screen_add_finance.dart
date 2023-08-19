import 'package:budget/models/categories.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenAddFinance extends ChangeNotifier {
  List<bool> finance = [true, false]; //Расход_Доход
  late List<Category> listCategory;

  int financeSwitch = 0;

  Category selectCategory(int index) {
    return listCategory[index];
  }

  Future getListCategory() async {
    final list = await DBFinance.getListCategory(financeSwitch);
    listCategory = list;
  }

  void updateScreen() async {
    notifyListeners();
  }

  void onPressedSwitchExpInc(int finace) {
    financeSwitch = finace;
    updateScreen();
  }
}

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
