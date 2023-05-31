import 'dart:math';

import 'package:budget/screen2/const/const_color.dart';
import 'package:flutter/material.dart';

class ProviderScreenAddCategory extends ChangeNotifier {
  ProviderScreenAddCategory(this.isSelectedBudget) {
    loadColor();
  }
  final List<bool> isSelectedBudget;
  late Color color;
  final List<String> listSubCategory = [
    'Rhjcc,',
    'sdsdsd',
    'dsdsd',
    'Rhjcc,',
    'sdsdsd',
    'dsdsd',
    'Rhjcc,',
    'sdsdsd',
    'dsdsd',
    'Rhjcc,',
    'sdsdsd',
    'dsdsd',
  ];

  String titleAppBar() => isSelectedBudget[0] ? 'Расход' : 'Доход';

  void onPressedButtonColor(Color onColorChanged) {
    color = onColorChanged;
    notifyListeners();
  }

  void loadColor() {
    final index = Random().nextInt(ColorApp.listColor.length);
    color = ColorApp.listColor[index];
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
