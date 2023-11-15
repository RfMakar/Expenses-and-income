import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/models/switch_date.dart';
import 'package:flutter/material.dart';

class ModelMaterialApp extends ChangeNotifier {
  final finance = Finance();
  final switchDate = SwitchDate();

  void updateApp() {
    notifyListeners();
  }
}
