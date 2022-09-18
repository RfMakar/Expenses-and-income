import 'package:budget/model/shop_list.dart';

class ModelShopList {
  ModelShopList(this._shopList);
  final ShopList _shopList;

  String get nameProduct => _shopList.nameProduct;

  String get nameList => _shopList.nameList;

  bool get select => _shopList.isSelected == 0 ? false : true;

  ShopList get shopList => _shopList;
}
