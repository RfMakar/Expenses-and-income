import 'package:budget/database/budget/db_budget.dart';
import 'package:budget/database/budget/db_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';

import '../../widget/my_widget.dart';

class ModelScreenNewEditSubcategory extends ChangeNotifier {
  final List<bool> isSelectedBudget;
  var textController = TextEditingController();
  var validateTextField = false;
  late Category categoryNew;
  late Category categoryEdit;

  ModelScreenNewEditSubcategory(this.categoryNew, this.isSelectedBudget);

  ModelScreenNewEditSubcategory.edit(this.categoryEdit, this.isSelectedBudget) {
    textController.text = categoryEdit.subname!;
    categoryNew = Category.clonesub(categoryEdit);
  }

  void onPressedButtonAddSubcategory(BuildContext context) async {
    if (textController.text.isNotEmpty) {
      categoryNew.subname = textController.text;
      if (isSelectedBudget[0]) {
        var check =
            await DBSubcategory.checkCatSubName('expsubcattab', categoryNew);
        if (check) {
          MyWidget.mySnackBar(context, 'Подкатегория существует');
        } else {
          DBSubcategory.insert('expsubcattab', categoryNew);
          Navigator.pop(context);
          Navigator.pop(context, categoryNew);
        }
      } else {
        var check =
            await DBSubcategory.checkCatSubName('incsubcattab', categoryNew);
        if (check) {
          MyWidget.mySnackBar(context, 'Подкатегория существует');
        } else {
          DBSubcategory.insert('incsubcattab', categoryNew);
          Navigator.pop(context);
          Navigator.pop(context, categoryNew);
        }
      }
    } else {
      validateTextField = true;
      notifyListeners();
    }
  }

  void onPressedButtonCreateSubcategory(BuildContext context) async {
    if (textController.text.isNotEmpty) {
      categoryNew.subname = textController.text;
      if (isSelectedBudget[0]) {
        var check =
            await DBSubcategory.checkCatSubName('expsubcattab', categoryNew);
        if (check) {
          MyWidget.mySnackBar(context, 'Подкатегория существует');
        } else {
          DBSubcategory.update('expsubcattab', categoryNew, categoryEdit);
          DBBudget.updateSubCategory('exptab', categoryNew, categoryEdit);
          Navigator.pop(context);
        }
      } else {
        var check =
            await DBSubcategory.checkCatSubName('incsubcattab', categoryNew);
        if (check) {
          MyWidget.mySnackBar(context, 'Подкатегория существует');
        } else {
          DBSubcategory.update('incsubcattab', categoryNew, categoryEdit);
          DBBudget.updateSubCategory('inctab', categoryNew, categoryEdit);
          Navigator.pop(context);
        }
      }
    } else {
      validateTextField = true;
      notifyListeners();
    }
  }
}
