import 'package:budget/model/categories.dart';
import 'package:budget/model/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/const/db.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddSubCategories extends ChangeNotifier {
  final Categories categories;
  ProviderDialogAddSubCategories(this.categories);
  final textEditingControllerName = TextEditingController();

  Color colorDialog() => Color(int.parse(categories.color));
  String titleDialog() => categories.name;
  final formKey = GlobalKey<FormState>();

  bool onPressedButtonAddCategories() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBCategories();
      return true;
    }
  }

  void insertDBCategories() {
    final subCategories = SubCategories(
      idcategories: categories.id,
      name: textEditingControllerName.text.trim(),
    );
    DBFinance.insert(DBTableSubCategories.name, subCategories.toMap());
  }
}
