import 'package:budget/model/roster.dart';
import 'package:budget/model/shop_list.dart';
import 'package:budget/screen/list/shop_list/model_shop_list.dart';
import 'package:flutter/material.dart';
import 'package:budget/database/list/db_shop_list.dart';

class ScreenModelShopList extends ChangeNotifier {
  final Roster _roster;
  var textController = TextEditingController();
  var _validateTextField = false;
  var addEditButton = true;
  late ShopList editShopList;

  ScreenModelShopList(this._roster);

  String? errorText() {
    return _validateTextField ? 'Введите текст' : null;
  }

  void onPressedIconButtonAddRoster() {
    var nameProduct = textController.text;
    if (nameProduct.isNotEmpty) {
      final newShopList = ShopList(
        nameList: _roster.name,
        nameProduct: nameProduct,
        isSelected: 0,
      );
      DBShopList.insert(newShopList);
      _clearTextField();
    } else {
      _errorTextField();
    }
  }

  void onPressedIconButtonEditRoster() {
    var nameProduct = textController.text;
    if (nameProduct.isNotEmpty) {
      final newShopList = ShopList(
        nameList: _roster.name,
        nameProduct: nameProduct,
        isSelected: 0,
      );
      DBShopList.update(newShopList, editShopList);
      _clearTextField();
    } else {
      _errorTextField();
    }
  }

  void _clearTextField() {
    textController.clear();

    if (_validateTextField) {
      _validateTextField = false;
    }
    if (!addEditButton) {
      addEditButton = true;
    }
    notifyListeners();
  }

  void _errorTextField() {
    _validateTextField = true;
    notifyListeners();
  }

  void onTapMenuDeleteAll() {
    DBShopList.deleteRoster(_roster);
    notifyListeners();
  }

  void onTapMenuDeleteSelect() {
    DBShopList.deleteSelect(_roster);
    notifyListeners();
  }

  void onLongPressListTileDelete(ModelShopList modelShopList) {
    DBShopList.delete(modelShopList.shopList);
    notifyListeners();
  }

  void onLongPressListTileEdit(ModelShopList modelShopList) {
    textController.text = modelShopList.nameProduct;
    addEditButton = false;
    editShopList = modelShopList.shopList;
    notifyListeners();
  }

  void onTapListTile(ModelShopList modelShopList) {
    editShopList = modelShopList.shopList;

    final newShopList = ShopList(
      nameList: modelShopList.nameList,
      nameProduct: modelShopList.nameProduct,
      isSelected: modelShopList.select == false ? 1 : 0,
    );

    DBShopList.update(newShopList, editShopList);
    notifyListeners();
  }

  Future<List<ModelShopList>> getList() async {
    List<ModelShopList> listModelShop = [];
    var list = await DBShopList.getList(_roster);
    for (var shop in list) {
      listModelShop.add(ModelShopList(shop));
    }
    return listModelShop;
  }
}
