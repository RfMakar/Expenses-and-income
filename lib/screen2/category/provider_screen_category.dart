import 'package:budget/model/category.dart';
import 'package:budget/model/subcategory.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/screen2/const/db.dart';
import 'package:flutter/material.dart';

class ProviderScreenCategory extends ChangeNotifier {
  final Category category;

  ProviderScreenCategory(this.category);

  Future<List<SubCategory>> getListSubCategory() {
    return DBFinance.getListSubCategory(DBTable.expenses, category);
  }
}
