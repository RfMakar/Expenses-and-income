import 'dart:math';
import 'package:budget/const/color.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddAccount extends ChangeNotifier {
  final DateTime dateTime = DateTime.now();
  final textEditingControllerName = TextEditingController();
  final textEditingControllerValue = TextEditingController(text: '0');
  Color colorDialog =
      ColorApp.listColor[Random().nextInt(ColorApp.listColor.length)];

  final formKey = GlobalKey<FormState>();

  void updateColorDialog(Color color) {
    colorDialog = color;
    notifyListeners();
  }

  bool onPressedButtonAddAccount() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      saveAccountToDB();
      return true;
    }
  }

  void saveAccountToDB() async {
    // final account = Account(
    //   name: textEditingControllerName.text.trim(),
    //   color: colorDialog.value.toString(),
    // );

    // final idAccount =
    //     await DBFinance.insert(DBTableAccount.name, account.toMap());
    // saveTransactionsToDB(idAccount);
  }

  void saveTransactionsToDB(int idAccount) async {
    // final transaction = Transactions(
    //   idAccount: idAccount,
    //   idSubCategories: null,
    //   date: dateTime.toString(),
    //   year: dateTime.year,
    //   month: dateTime.month,
    //   day: dateTime.day,
    //   value: double.parse(textEditingControllerValue.text.trim()),
    //   note: null,
    // );
    //await DBFinance.insert(DBTable.transactions, transaction.toMap());
  }
}
