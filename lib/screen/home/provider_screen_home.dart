import 'package:budget/screen/analytics/screen_analytics.dart';
import 'package:budget/screen/data_app/screen_data_app.dart';
import 'package:budget/screen/finance/screen_finance.dart';
import 'package:budget/screen/settings/screen_settings.dart';
import 'package:flutter/material.dart';

class ProviderScreenHome extends ChangeNotifier {
  int _selectedIndex = 0;
  final List<Widget> _listWidgetScreen = const [
    ScreenFinance(),
    ScreenAnalytics(),
    ScreenDataApp(),
    ScreenSettings(),
  ];
  final List<String> _listNameAppBar = const [
    'Финансы',
    'Аналитика',
    'Данные',
    'Настройки',
  ];

  Widget widgetScreen() {
    return _listWidgetScreen[_selectedIndex];
  }

  void updateScreen() {
    notifyListeners();
  }

  String titleAppBar() {
    return _listNameAppBar[_selectedIndex];
  }

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
