import 'package:budget/const/db.dart';
import 'package:budget/model/operations.dart';
import 'package:budget/model/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddOperations extends ChangeNotifier {
  ProviderDialogAddOperations(this.subCategories);
  final SubCategories subCategories;
  final textEditingControllerValue = TextEditingController();
  final textEditingControllerNote = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var dateTime = DateTime.now();

  String titleDialog() {
    return subCategories.name;
  }

  void onChangedDate(DateTime newDateTime) {
    dateTime = newDateTime;
  }

  bool onPressedButtonAddCategories() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      isertDBOperations();
      return true;
    }
  }

  void isertDBOperations() {
    final operations = Operations(
      idsubcategories: subCategories.id,
      date: dateTime.toString(),
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
      value: double.parse(textEditingControllerValue.text.trim()),
      note: textEditingControllerNote.text.trim(),
    );
    DBFinance.insert(DBTableOperations.name, operations.toMap());
  }
}
