import 'package:flutter/material.dart';

class ProviderScreenAddFinance extends ChangeNotifier {
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  var isSelectedSwitchExpInc = [true, false];
  final textEditingControllerValue = TextEditingController();

  DateTime get dateTime => _dateTime ?? DateTime.now();
  TimeOfDay get timeOfDay => _timeOfDay ?? TimeOfDay.now();

  void onPressedSwitchExpInc(List<bool> list) {
    print(list);
  }

  void onChangedDate(DateTime dateTime) {
    _dateTime = dateTime;
  }

  void onChangedTime(TimeOfDay timeOfDay) {
    _timeOfDay = timeOfDay;
  }
}
