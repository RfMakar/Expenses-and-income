import 'dart:math';
import 'package:budget/models/categories.dart';
import 'package:budget/models/finance.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/const/color.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddCategory extends ChangeNotifier {
  ProviderDialogAddCategory(this.finance);
  final Finance finance;

  final textEditingControllerName = TextEditingController();

  Color colorDialog =
      ColorApp.listColor[Random().nextInt(ColorApp.listColor.length)];
  String titleDialog() {
    return finance.titleFinance();
  }

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
      idfinance: finance.id,
      name: textEditingControllerName.text.trim(),
      color: colorDialog.value.toString(),
    );
    DBFinance.insertCategory(writeCategory);
  }
}
