import 'package:budget/model/category.dart';
import 'package:budget/model/operation.dart';
import 'package:budget/model/subcategory.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/screen2/const/db_table.dart';
import 'package:flutter/material.dart';

class ProviderScreenSubCategory extends ChangeNotifier {
  final Category category;
  final SubCategory subCategory;

  ProviderScreenSubCategory(this.category, this.subCategory);

  Future<List<Operation>> getListOperationsy() {
    return DBFinance.getListOperations(DBTable.expenses, category, subCategory);
  }
}
