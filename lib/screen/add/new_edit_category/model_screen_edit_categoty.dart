import 'package:budget/database/budget/db_budget.dart';
import 'package:budget/database/budget/db_category.dart';
import 'package:budget/database/budget/db_subcategory.dart';
import 'package:budget/screen/widget/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';

class ModelScreenEditCategory extends ChangeNotifier {
  final List<bool> isSelectedBudget;
  final Category editCategory;
  var textController = TextEditingController();
  var validateTextField = false;
  late Color colorIcon;

  ModelScreenEditCategory(this.editCategory, this.isSelectedBudget) {
    textController.text = editCategory.name;
    colorIcon = Color(editCategory.color);
  }

  void onPressedButtonSelectColor(Color color) {
    colorIcon = color;
    notifyListeners();
  }

  void _errorTextField() {
    validateTextField = true;
    notifyListeners();
  }

  void onPressedButtonCreateCategory(BuildContext context) async {
    var nameCategory = textController.text;
    if (nameCategory.isNotEmpty) {
      final newCategory = Category(name: nameCategory, color: colorIcon.value);
      if (isSelectedBudget[0]) {
        var check = await DBCategory.checkCatName('expcattab', newCategory);
        if (check) {
          MyWidget.mySnackBar(context, 'Категория существует');
        } else {
          DBCategory.update('expcattab', newCategory, editCategory);
          DBSubcategory.updateCategory(
              'expsubcattab', newCategory, editCategory);
          DBBudget.updateCategory('exptab', newCategory, editCategory);
          Navigator.pop(context);
        }
      } else {
        var check = await DBCategory.checkCatName('inccattab', newCategory);
        if (check) {
          MyWidget.mySnackBar(context, 'Категория существует');
        } else {
          DBCategory.update('inccattab', newCategory, editCategory);
          DBSubcategory.updateCategory(
              'incsubcattab', newCategory, editCategory);
          DBBudget.updateCategory('inctab', newCategory, editCategory);
          Navigator.pop(context);
        }
      }
    } else {
      _errorTextField();
    }
  }
}
