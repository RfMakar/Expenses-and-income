import 'dart:math';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:budget/const/color.dart';
import 'package:flutter/material.dart';

class ModelDialogAddCategory extends ChangeNotifier {
  ModelDialogAddCategory(this._finance) {
    _colorCategory =
        ColorApp.listColor[Random().nextInt(ColorApp.listColor.length)];
  }
  final Finance _finance;
  late Color _colorCategory;

  String titleDialog() => _finance.titleFinance();

  Color colorIconDialog() {
    return _colorCategory;
  }

  void updateColor(Color color) {
    _colorCategory = color;
    notifyListeners();
  }

  void onPressedButtonAddCategory(String nameCategory) {
    final writeCategory = WriteCategory(
      idfinance: _finance.id,
      name: nameCategory,
      color: _colorCategory.value.toString(),
    );
    DBFinance.insertCategory(writeCategory);
  }
}
