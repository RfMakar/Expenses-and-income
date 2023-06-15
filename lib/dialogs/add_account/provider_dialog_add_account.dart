import 'dart:math';
import 'package:budget/model/account.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/screen2/const/const_color.dart';
import 'package:budget/screen2/const/db_table.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddAccount extends ChangeNotifier {
  final textEditingControllerName = TextEditingController();
  final textEditingControllerValue = TextEditingController(text: '0');
  Color colorDialog =
      ColorApp.listColor[Random().nextInt(ColorApp.listColor.length)];

  final formKey = GlobalKey<FormState>();

  void updateColorDialog(Color color) {
    colorDialog = color;
    notifyListeners();
  }

  void onPressedButtonAddAccount() {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      saveAccountToDB();
    }
  }

  void saveAccountToDB() {
    final account = Account(
      name: textEditingControllerName.text.trim(),
      color: colorDialog.value.toString(),
    );
    DBFinance.insert(DBTable.account, account.toMap());
  }
}
