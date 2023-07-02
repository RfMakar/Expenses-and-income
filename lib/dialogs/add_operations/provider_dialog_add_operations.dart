import 'package:budget/model/subcategories.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddOperations extends ChangeNotifier {
  ProviderDialogAddOperations(this.subCategories);
  final SubCategories subCategories;
  final textEditingControllerValue = TextEditingController();
  final textEditingControllerNote = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  String titleDialog() {
    return subCategories.name;
  }

  void onChangedDate(DateTime newDateTime) {
    dateTime = newDateTime;
  }

  void onChangedTime(TimeOfDay newTimeOfDay) {
    timeOfDay = newTimeOfDay;
  }

  bool onPressedButtonAddCategories() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      isertDBOperations();
      return true;
    }
  }

  void isertDBOperations() {}
}
