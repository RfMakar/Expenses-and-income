import 'package:budget/repositories/finanse/models/categories.dart';
import 'package:budget/repositories/finanse/models/subcategories.dart';
import 'package:budget/repositories/finanse/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddSubCategory extends ChangeNotifier {
  final Category category;
  ProviderDialogAddSubCategory(this.category);
  final textEditingControllerName = TextEditingController();

  String titleDialog() => category.name;
  final formKey = GlobalKey<FormState>();

  bool onPressedButtonAddCategory() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBCategory();
      return true;
    }
  }

  void insertDBCategory() {
    final writeSubCategory = WriteSubCategory(
      idCategory: category.id,
      name: textEditingControllerName.text.trim(),
    );
    DBFinance.insertSubCategory(writeSubCategory);
  }
}
