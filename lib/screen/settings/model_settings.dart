import 'package:budget/database/budget/db_budget.dart';
import 'package:budget/database/budget/db_category.dart';
import 'package:budget/database/budget/db_subcategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:budget/database/list/db_shop_list.dart';
import 'package:budget/database/list/db_roster.dart';

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

  void deleteAllLists() {
    DBShopList.deleteShopListTable();
    DBRoster.deleteRosterTable();
  }

  void deleteAllBD() {
    deleteAllExpenses();
    deleteAllIncome();
    deleteAllLists();
  }
}
