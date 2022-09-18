import 'package:budget/database/budget/db_budget.dart';
import 'package:budget/database/budget/db_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';
import 'package:budget/screen/add/new_edit_subcategory/screen_edit_subcategory.dart';

class ModelScreenSeletionSubcategory extends ChangeNotifier {
  ModelScreenSeletionSubcategory(this.category, this.isSelectedBudget);
  final Category category;
  final List<bool> isSelectedBudget;

  void onLongPressListTileDelete(BuildContext context, Category category) {
    if (isSelectedBudget[0]) {
      DBSubcategory.delete('expsubcattab', category);
      DBBudget.deleteSubCategory('exptab', category);
    } else {
      DBSubcategory.delete('incsubcattab', category);
      DBBudget.deleteSubCategory('inctab', category);
    }
    notifyListeners();
  }

  void onLongPressListTileEdit(BuildContext context, Category category) async {
    Navigator.pop(context);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenEditSubcategory(
          category: category,
          isSelectedBudget: isSelectedBudget,
        ),
      ),
    );
    notifyListeners();
  }

  Future<List<Category>> subcategoryList() {
    if (isSelectedBudget[0]) {
      return DBSubcategory.getList('expsubcattab', category);
    } else {
      return DBSubcategory.getList('incsubcattab', category);
    }
  }
}
