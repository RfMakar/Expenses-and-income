import 'package:budget/repositories/finanse/models/operations.dart';
import 'package:budget/repositories/finanse/models/subcategories.dart';
import 'package:budget/repositories/finanse/sqllite/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddOperation extends ChangeNotifier {
  ProviderDialogAddOperation(this.subCategory);
  final SubCategory subCategory;
  final textEditingControllerValue = TextEditingController();
  final textEditingControllerNote = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var dateTime = DateTime.now();

  String titleDialog() {
    return subCategory.name;
  }

  void onChangedDate(DateTime newDateTime) {
    dateTime = newDateTime;
  }

  bool onPressedButtonAddCategory() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      isertDBOperation();
      return true;
    }
  }

  void isertDBOperation() async {
    final writeOperation = WriteOperation(
      idSubcategory: subCategory.id,
      date: dateTime.toString(),
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
      note: textEditingControllerNote.text.trim(),
      value: double.parse(textEditingControllerValue.text.trim()),
    );
    await DBFinance.insertOperation(writeOperation);
  }
}
