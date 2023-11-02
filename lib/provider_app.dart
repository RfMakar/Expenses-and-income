import 'package:budget/models/app_finance/finance.dart';
import 'package:budget/models/app_finance/switch_date.dart';
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
