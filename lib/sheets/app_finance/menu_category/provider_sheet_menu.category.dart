import 'package:budget/models/app_finance/categories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuCategory extends ChangeNotifier {
  ProviderSheetMenuCategory(this.category);
  final Category category;

  String nameSheet() {
    return category.name;
  }

  Color colorCategory() {
    return Color(int.parse(category.color));
  }

  void onTapRenamedCategory(String newName) async {
    await DBFinance.updateCategoryName(newName, category);
  }

  void onTapDeletedCategory() async {
    await DBFinance.deleteCategory(category);
  }

  void onTapChangeColorCategory(Color newColor) async {
    await DBFinance.updateCategoryColor(newColor.value.toString(), category);
  }
}
