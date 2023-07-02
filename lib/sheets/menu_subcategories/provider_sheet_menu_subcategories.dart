import 'package:budget/const/db.dart';
import 'package:budget/model/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuSubCategories extends ChangeNotifier {
  ProviderSheetMenuSubCategories(this.subCategories, this.financeSwitch);
  final SubCategories subCategories;
  final int financeSwitch;

  String titleSheet() {
    return subCategories.name;
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

  void onTapRenamedSubCategories(String newName) async {
    await DBFinance.rawUpdate(
        DBTableSubCategories.updateName(), [newName, subCategories.id]);
  }

  void onTapDeletedSubCategories() async {
    await DBFinance.rawDelete(
        DBTableSubCategories.deletedSubCategories(), [subCategories.id]);
  }
}
