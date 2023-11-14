import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';

class ModelSheetMenuCategory {
  ModelSheetMenuCategory(this._category);
  final Category _category;

  String nameSheet() => _category.name;

  void onTapRenamedCategory(String newName) {
    _category.rename(newName);
    DBFinance.updateCategoryName(newName, _category.id);
  }

  void onTapDeletedCategory() {
    DBFinance.deleteCategory(_category);
  }

  void onTapChangeColorCategory(String newColor) {
    _category.changeColor(newColor);
    DBFinance.updateCategoryColor(newColor, _category.id);
  }
}
