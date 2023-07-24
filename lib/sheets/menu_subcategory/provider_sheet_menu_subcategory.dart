import 'package:budget/models/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuSubCategory extends ChangeNotifier {
  ProviderSheetMenuSubCategory(this.subCategory, this.financeSwitch);
  final SubCategory subCategory;
  final int financeSwitch;

  String titleSheet() {
    return subCategory.name;
  }

  String titleButtonAddFinace() {
    if (financeSwitch == 0) {
      return 'Добавить расход';
    } else if (financeSwitch == 1) {
      return 'Добавить доход';
    } else {
      return '';
    }
  }

  void onTapRenamedSubCategory(String newName) async {
    await DBFinance.updateSubCategoryName(newName, subCategory);
  }

  void onTapDeletedSubCategory() async {
    await DBFinance.deleteSubCategory(subCategory);
  }
}
