import 'package:flutter/material.dart';

class ProviderDialogAddShopList extends ChangeNotifier {
  final textEditingControllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool onPressedButtonAddShopList() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBCategory();
      return true;
    }
  }

  void insertDBCategory() {
    // final writeCategory = WriteCategory(
    //   idfinance: finance.id,
    //   name: textEditingControllerName.text.trim(),
    //   color: colorDialog.value.toString(),
    // );
    // DBFinance.insertCategory(writeCategory);
  }
}
