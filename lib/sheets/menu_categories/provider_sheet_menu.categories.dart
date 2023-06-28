import 'package:budget/const/db.dart';
import 'package:budget/model/categories.dart';
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

  void onTapRenamedCategories() {}
  void onTapDeletedCategories() {
    DBFinance.rawDelete(DBTableCategories.deletedRow(), [categories.id]);
  }

  void onTapChangeColorCategories() {}
}
