import 'package:budget/const/db.dart';
import 'package:budget/models/categories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuCategories extends ChangeNotifier {
  ProviderSheetMenuCategories(this.categories);
  final Categories categories;

  String nameSheet() {
    return categories.name;
  }

  Color colorCategories() {
    return Color(int.parse(categories.color));
  }

  void onTapRenamedCategories(String newName) async {
    await DBFinance.rawUpdate(
        DBTableCategories.updateName(), [newName, categories.id]);
  }

  void onTapDeletedCategories() async {
    await DBFinance.rawDelete(
        DBTableCategories.deletedCategories(), [categories.id]);
  }

  void onTapChangeColorCategories(Color newColor) async {
    await DBFinance.rawUpdate(DBTableCategories.updateColor(),
        [newColor.value.toString(), categories.id]);
  }
}
