import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';

class ModelSheetMenuSubCategory {
  ModelSheetMenuSubCategory(this._subCategory);
  final SubCategory _subCategory;

  String titleSheet() => _subCategory.name;

  void onTapRenamedSubCategory(String newName) {
    DBFinance.updateSubCategoryName(newName, _subCategory);
  }

  void onTapDeletedSubCategory() async {
    DBFinance.deleteSubCategory(_subCategory);
  }
}
