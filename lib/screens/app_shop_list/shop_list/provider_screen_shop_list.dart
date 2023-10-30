import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:budget/repository/db_shop_lists.dart';
import 'package:flutter/foundation.dart';

class ProviderScreenShopList extends ChangeNotifier {
  late List<ShopList> listShopList;

  void updateScreen() async {
    notifyListeners();
  }

  Future getListShopList() async {
    listShopList = await DBShopList.getListShopList();
  }

  String titleListShop(int index) {
    return listShopList[index].name;
  }

  ShopList shopList(int index) {
    return listShopList[index];
  }
}
