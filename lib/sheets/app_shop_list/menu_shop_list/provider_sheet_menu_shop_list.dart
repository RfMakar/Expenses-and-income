import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:budget/repository/db_shop_lists.dart';
import 'package:flutter/foundation.dart';

class ProviderSheetMenuShopList extends ChangeNotifier {
  final ShopList shopList;
  ProviderSheetMenuShopList(this.shopList);

  String nameSheet() {
    return shopList.name;
  }

  void onTapRenamedShopList(String newName) async {
    await DBShopList.updateShopListName(newName, shopList.id);
  }

  void onTapDeletedShopList() async {
    await DBShopList.deleteShopList(shopList.id);
  }
}
