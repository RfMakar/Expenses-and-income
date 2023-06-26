import 'dart:math';
import 'package:budget/screen2/const/const_color.dart';
import 'package:flutter/material.dart';

class ProviderScreenAddCategory extends ChangeNotifier {
  ProviderScreenAddCategory(this.isSelectedBudget) {
    loadColor();
  }
  final List<bool> isSelectedBudget;
  late Color color;
  final List<String> listSubCategory = [];
  final texEdConCategory = TextEditingController();

  String titleAppBar() => isSelectedBudget[0] ? 'Расход' : 'Доход';

  void onPressedButtonColor(Color onColorChanged) {
    color = onColorChanged;
    notifyListeners();
  }

  void onPressedAddNewCategoy() async {
    // for (var subCat in listSubCategory) {
    // final finance = Finance(
    //   date: DateTime.now().toString(),
    //   category: texEdConCategory.text.trim(),
    //   subcategory: subCat,
    //   value: 0,
    //   comment: '',
    //   color: color.value.toString(),
    // );
    //await DBFinance.insert(DBTable.expenses, finance);
    // }
  }

  void loadColor() {
    final index = Random().nextInt(ColorApp.listColor.length);
    color = ColorApp.listColor[index];
    print(color.value);
  }

  void onPressedNewSubCategoru(String name) {
    listSubCategory.insert(0, name);
    notifyListeners();
  }

  void onPressedDeleteSubCategory(int index) {
    listSubCategory.removeAt(index);
    notifyListeners();
  }

  void onPressedEditSubcategory(String name, int index) {
    listSubCategory[index] = name;
    notifyListeners();
  }
}
