import 'package:budget/database/budget/db_budget.dart';
import 'package:budget/database/budget/db_category.dart';
import 'package:budget/database/budget/db_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';
import 'package:budget/screen/add/new_edit_category/screen_edit_category.dart';

class ModelScreenSeletionCategory extends ChangeNotifier {
  ModelScreenSeletionCategory(this.isSelectedBudget);
  final List<bool> isSelectedBudget;

  void onLongPressListTileDelete(Category category) {
    if (isSelectedBudget[0]) {
      DBCategory.delete('expcattab', category);
      DBSubcategory.deleteCategory('expsubcattab', category);
      DBBudget.deleteCategory('exptab', category);
    } else {
      DBCategory.delete('inccattab', category);
      DBSubcategory.deleteCategory('incsubcattab', category);
      DBBudget.deleteCategory('inctab', category);
    }

    notifyListeners();
  }

  void onLongPressListTileEdit(BuildContext context, Category category) async {
    Navigator.pop(context);
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScreenEditCategory(
                category: category,
                isSelectedBudget: isSelectedBudget,
              )),
    );
    notifyListeners();
  }

  Future<List<Category>> categoryList() {
    if (isSelectedBudget[0]) {
      return DBCategory.getList('expcattab');
    } else {
      return DBCategory.getList('inccattab');
    }
  }
}
