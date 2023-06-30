import 'dart:math';
import 'package:budget/model/categories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/const/color.dart';
import 'package:budget/const/db.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddCategories extends ChangeNotifier {
  final int idoperations;
  ProviderDialogAddCategories(this.idoperations);
  final textEditingControllerName = TextEditingController();

  Color colorDialog =
      ColorApp.listColor[Random().nextInt(ColorApp.listColor.length)];
  String titleDialog() => idoperations == 0 ? 'Расход' : 'Доход';
  final formKey = GlobalKey<FormState>();

  void updateColorDialog(Color color) {
    colorDialog = color;
    notifyListeners();
  }

  bool onPressedButtonAddCategories() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBCategories();
      return true;
    }
  }

  void insertDBCategories() {
    final categories = Categories(
      idoperations: idoperations,
      name: textEditingControllerName.text.trim(),
      color: colorDialog.value.toString(),
    );
    DBFinance.insert(DBTableCategories.name, categories.toMap());
  }
}
