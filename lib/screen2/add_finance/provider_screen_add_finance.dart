import 'package:flutter/material.dart';

class ProviderScreenAddFinance extends ChangeNotifier {
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  List<bool>? finance; //Расход_Доход

  final textEditingControllerValue = TextEditingController();

  DateTime get dateTime => _dateTime ?? DateTime.now();
  TimeOfDay get timeOfDay => _timeOfDay ?? TimeOfDay.now();

  void updateScreen() {
    notifyListeners();
  }

  void onPressedSwitchExpInc(List<bool> list) {
    finance = list;
  }

  void onChangedDate(DateTime dateTime) {
    _dateTime = dateTime;
  }

  void onChangedTime(TimeOfDay timeOfDay) {
    _timeOfDay = timeOfDay;
  }
}
