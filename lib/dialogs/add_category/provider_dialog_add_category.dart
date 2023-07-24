import 'dart:math';
import 'package:budget/models/categories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/const/color.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddCategory extends ChangeNotifier {
  final int idfinance;
  ProviderDialogAddCategory(this.idfinance);
  final textEditingControllerName = TextEditingController();

  Color colorDialog =
      ColorApp.listColor[Random().nextInt(ColorApp.listColor.length)];
  String titleDialog() => idfinance == 0 ? 'Расход' : 'Доход';
  final formKey = GlobalKey<FormState>();

  void updateColorDialog(Color color) {
    colorDialog = color;
    notifyListeners();
  }

  bool onPressedButtonAddCategory() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBCategory();
      return true;
    }
  }

  void insertDBCategory() {
    final writeCategory = WriteCategory(
      idfinance: idfinance,
      name: textEditingControllerName.text.trim(),
      color: colorDialog.value.toString(),
    );
    DBFinance.insertCategory(writeCategory);
  }
}
