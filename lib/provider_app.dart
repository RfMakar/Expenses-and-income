import 'package:budget/repositories/finance/models/finance.dart';
import 'package:budget/repositories/finance/models/switch_date.dart';
import 'package:flutter/material.dart';

class ProviderApp extends ChangeNotifier {
  final finance = Finance();
  final switchDate = SwitchDate();
  late bool themeDart;

  void onPressedButFinance(int index) {
    finance.onPressed(index);
    notifyListeners();
  }

  void updateApp() {
    notifyListeners();
  }
}
