import 'package:budget/models/app_finance/operations.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderDialogEditOperation extends ChangeNotifier {
  ProviderDialogEditOperation(this.operation) {
    textEditingControllerValue.text = operation.value.toString();
    textEditingControllerNote.text = operation.note;
  }
  final Operation operation;
  final formKey = GlobalKey<FormState>();
  final textEditingControllerValue = TextEditingController();
  final textEditingControllerNote = TextEditingController();

  bool onPressedButtonEditOperation() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      editDBOperration();
      return true;
    }
  }

  void editDBOperration() async {
    final newValue = double.parse(textEditingControllerValue.text.trim());
    final newNote = textEditingControllerNote.text.trim();

    await DBFinance.updateOperation(newValue, newNote, operation);
  }
}
