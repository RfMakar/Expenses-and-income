import 'package:budget/const/db.dart';
import 'package:budget/model/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuSubCategories extends ChangeNotifier {
  ProviderSheetMenuSubCategories(this.subCategories);
  final SubCategories subCategories;

  String nameSheet() {
    return subCategories.name;
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
