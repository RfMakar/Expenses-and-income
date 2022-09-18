import 'package:budget/database/budget/db_category.dart';
import 'package:budget/screen/widget/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';

class ModelScreenNewCategory extends ChangeNotifier {
  final List<bool> isSelectedBudget;
  var textController = TextEditingController();
  var validateTextField = false;
  var colorIcon = Colors.black;

  ModelScreenNewCategory(this.isSelectedBudget);

  void onPressedButtonSelectColor(Color color) {
    colorIcon = color;
    notifyListeners();
  }

  void _errorTextField() {
    validateTextField = true;
    notifyListeners();
  }

  void onPressedButtonAddCategory(BuildContext context) async {
    var nameCategory = textController.text;
    if (nameCategory.isNotEmpty) {
      final newCategory = Category(name: nameCategory, color: colorIcon.value);

      if (isSelectedBudget[0]) {
        var check = await DBCategory.checkCatName('expcattab', newCategory);
        if (check) {
          MyWidget.mySnackBar(context, 'Категория существует');
        } else {
          DBCategory.insert('expcattab', newCategory);
          Navigator.pop(context);
          Navigator.pop(context, newCategory);
        }
      } else {
        var check = await DBCategory.checkCatName('inccattab', newCategory);
        if (check) {
          MyWidget.mySnackBar(context, 'Категория существует');
        } else {
          DBCategory.insert('inccattab', newCategory);
          Navigator.pop(context);
          Navigator.pop(context, newCategory);
        }
      }
    } else {
      _errorTextField();
    }
  }
}
