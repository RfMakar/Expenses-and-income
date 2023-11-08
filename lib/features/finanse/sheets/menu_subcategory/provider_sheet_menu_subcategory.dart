import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuSubCategory extends ChangeNotifier {
  ProviderSheetMenuSubCategory(this.subCategory);
  final SubCategory subCategory;

  String titleSheet() {
    return subCategory.name;
  }

  void onTapRenamedSubCategory(String newName) async {
    await DBFinance.updateSubCategoryName(newName, subCategory);
  }

  void onTapDeletedSubCategory() async {
    await DBFinance.deleteSubCategory(subCategory);
  }
}
