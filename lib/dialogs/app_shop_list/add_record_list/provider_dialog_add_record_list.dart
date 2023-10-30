import 'package:budget/models/app_shop_list/record_list.dart';
import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:budget/repository/db_shop_lists.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddRecordList extends ChangeNotifier {
  final ShopList shopList;
  ProviderDialogAddRecordList(this.shopList);
  final textEditingControllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool onPressedButtonAddRecordList() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBRecordList();
      return true;
    }
  }

  void insertDBRecordList() {
    final writeRecordList = WriteRecordList(
      name: textEditingControllerName.text.trim(),
      idshoplist: shopList.id,
      isselected: 0,
    );
    DBShopList.insertRecordList(writeRecordList);
  }
}
