import 'package:budget/models/app_shop_list/record_list.dart';
import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:budget/repository/db_shop_lists.dart';
import 'package:flutter/material.dart';

class ProviderScreenRecordlist extends ChangeNotifier {
  ProviderScreenRecordlist(this.shopList);
  final ShopList shopList;
  late List<RecordList> listRecordList;

  String titleAppBar() {
    return shopList.name;
  }

  RecordList recordList(int index) {
    return listRecordList[index];
  }

  bool valueSelectRecordList(int index) {
    return listRecordList[index].isselected == 0 ? false : true;
  }

  void onChangedListTile(bool select, int index) {
    final selected = select == false ? 0 : 1;
    final idRecordList = listRecordList[index].id;
    DBShopList.updateSelectedRecordList(selected, idRecordList);
    notifyListeners();
  }

  void onTapSelectListTile(int index) {
    final selected = listRecordList[index].isselected == 0 ? 1 : 0;
    final idRecordList = listRecordList[index].id;
    DBShopList.updateSelectedRecordList(selected, idRecordList);
    notifyListeners();
  }

  String titleCardRecordList(int index) {
    return listRecordList[index].name;
  }

  void updateScreen() async {
    notifyListeners();
  }

  Future getListRecord() async {
    listRecordList = await DBShopList.getListRecordList(shopList.id);
  }
}
