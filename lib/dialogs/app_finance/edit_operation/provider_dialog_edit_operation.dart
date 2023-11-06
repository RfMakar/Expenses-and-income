import 'package:budget/repositories/finanse/models/operations.dart';
import 'package:budget/repositories/finanse/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderDialogEditOperation extends ChangeNotifier {
  ProviderDialogEditOperation(this.operation) {
    textEditingControllerValue.text = operation.value.toString();
    textEditingControllerNote.text = operation.note;
    dateTime = DateTime.parse(operation.date);
  }
  final Operation operation;
  final formKey = GlobalKey<FormState>();
  final textEditingControllerValue = TextEditingController();
  final textEditingControllerNote = TextEditingController();
  late DateTime dateTime;

  void onChangedDate(DateTime newDateTime) {
    dateTime = newDateTime;
  }

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

    await DBFinance.updateOperation(dateTime, newValue, newNote, operation);
  }
}
