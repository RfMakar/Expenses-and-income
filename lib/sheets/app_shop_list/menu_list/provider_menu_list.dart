import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:budget/repository/db_shop_lists.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuList extends ChangeNotifier {
  final ShopList shopList;

  ProviderSheetMenuList(this.shopList);

  void markTheList() {
    DBShopList.markRecordList(shopList.id);
  }

  void restoreTheList() {
    DBShopList.restoreRecordList(shopList.id);
  }

  void deleteSelected() {
    DBShopList.deleteSelecetRecordList(shopList.id);
  }

  void clearTheList() {
    DBShopList.clearShopList(shopList.id);
  }
}
