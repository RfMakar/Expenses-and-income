import 'package:budget/database/theme/shared_prefer_theme.dart';
import 'package:budget/screen/list/roster/screen_roster.dart';
import 'package:flutter/material.dart';
import 'package:budget/screen/add/new_edit_budget/screen_new_budget.dart';
import 'package:budget/screen/home/screen_home.dart';
import 'package:budget/screen/settings/screen_settings.dart';

class ModelMaterialAppMain extends ChangeNotifier {
  Future<bool> getBoolDarckTheme() async {
    return SharPrefTheme.getBoolDarckTheme();
  }

  void setBoolDarckTheme(bool darchTheme) {
    SharPrefTheme.setBoolDarckTheme(darchTheme);
    notifyListeners();
  }
}

class ModelHomeMain extends ChangeNotifier {
  var selectedIndex = 0;
  static const listWidget = <Widget>[
    ScreenHome(),
    ScreenNewBudget(),
    ScreenRoster(),
    ScreenSettings(),
  ];

  Widget getWidgetOptions() => listWidget.elementAt(selectedIndex);

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  String titleAppBar() {
    switch (selectedIndex) {
      case 0:
        return 'Главная';
      case 1:
        return 'Добавить';
      case 2:
        return 'Список';
      case 3:
        return 'Настройки';
      default:
        return '';
    }
  }
}
