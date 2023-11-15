import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';

class ModelDialogAddSubCategory {
  ModelDialogAddSubCategory(this._category);
  final Category _category;

  String titleDialog() => _category.name;

  void onPressedButtonAddSubCategory(String nameSubCategory) {
    final writeSubCategory = WriteSubCategory(
      idCategory: _category.id,
      name: nameSubCategory,
    );

    DBFinance.insertSubCategory(writeSubCategory);
  }
}
