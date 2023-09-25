import 'package:budget/screen/analytics/screen_analytics.dart';
import 'package:budget/screen/data_app/screen_data_app.dart';
import 'package:budget/screen/finance/screen_finance.dart';
import 'package:budget/screen/settings/screen_settings.dart';
import 'package:flutter/material.dart';

class ProviderScreenHome extends ChangeNotifier {
  int selectedIndex = 0;
  final List<Widget> listWidgetScreen = const [
    ScreenFinance(),
    ScreenAnalytics(),
    ScreenDataApp(),
    ScreenSettings(),
  ];
  final List<String> listNameAppBar = const [
    'Финансы',
    'Аналитика',
    'Данные',
    'Настройки',
  ];

  Widget screen() {
    return listWidgetScreen[selectedIndex];
  }

  void updateScreen() {
    notifyListeners();
  }

  String titleAppBar() {
    return listNameAppBar[selectedIndex];
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
