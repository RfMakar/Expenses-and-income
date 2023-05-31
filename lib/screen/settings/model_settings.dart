import 'package:budget/database/budget/db_budget.dart';
import 'package:budget/database/budget/db_category.dart';
import 'package:budget/database/budget/db_subcategory.dart';
import 'package:flutter/cupertino.dart';

class ModelScreenSettings extends ChangeNotifier {
  void deleteAllExpenses() {
    DBBudget.deleteTable('exptab');
    DBCategory.deletCategoryTable('expcattab');
    DBSubcategory.deleteSubCategoryTable('expsubcattab');
  }

  void deleteAllIncome() {
    DBBudget.deleteTable('inctab');
    DBCategory.deletCategoryTable('inccattab');
    DBSubcategory.deleteSubCategoryTable('incsubcattab');
  }

  void deleteAllBD() {
    deleteAllExpenses();
    deleteAllIncome();
  }
}
