import 'package:budget/database/budget/db_budget.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/budget.dart';
import 'package:budget/screen/add/new_edit_budget/screen_edit_budget.dart';

class ModelScreenHistory extends ChangeNotifier {
  final DateTime dateTime;
  final List<bool> isSelected;
  final String nameCategory;
  final List<bool> isSelectedBudget;
  ModelScreenHistory({
    required this.dateTime,
    required this.isSelected,
    required this.nameCategory,
    required this.isSelectedBudget,
  });
//edit

  void onLongPressListTileDelete(BuildContext context, Budget budget) {
    if (isSelectedBudget[0]) {
      DBBudget.delete('exptab', budget);
    } else {
      DBBudget.delete('inctab', budget);
    }

    Navigator.pop(context);
    notifyListeners();
  }

  void onLongPressListTileEdit(BuildContext context, Budget budget) async {
    Navigator.pop(context);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenEditBudget(
          editBudget: budget,
          isSelectedBudget: isSelectedBudget,
        ),
      ),
    );
    notifyListeners();
  }

  Future<List<Budget>> historyListExpenses(String nameCategory) {
    if (isSelectedBudget[0]) {
      return DBBudget.getListHistoryToDate(
          'exptab', dateTime, isSelected, nameCategory);
    } else {
      return DBBudget.getListHistoryToDate(
          'inctab', dateTime, isSelected, nameCategory);
    }
  }
}
