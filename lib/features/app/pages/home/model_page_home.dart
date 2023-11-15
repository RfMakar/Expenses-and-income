import 'package:budget/features/finance/pages/finance/page_finance.dart';
import 'package:budget/features/shop_list/pages/shop_list/page_shop_list.dart';
import 'package:flutter/material.dart';

class ModelPageHome extends ChangeNotifier {
  int selectedIndex = 0;
  final List<Widget> _listWidgetScreen = const [
    PageFinance(),
    PageShopList(),
  ];
  final List<String> _listNameAppBar = const ['Финансы', 'Списки'];

  Widget widgetPage() {
    return _listWidgetScreen[selectedIndex];
  }

  void updateScreen() {
    notifyListeners();
  }

  String titleAppBar() {
    return _listNameAppBar[selectedIndex];
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
