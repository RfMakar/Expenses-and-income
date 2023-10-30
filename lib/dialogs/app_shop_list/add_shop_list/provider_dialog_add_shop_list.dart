import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:budget/repository/db_shop_lists.dart';
import 'package:flutter/material.dart';

class ProviderDialogAddShopList extends ChangeNotifier {
  final textEditingControllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool onPressedButtonAddShopList() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBShopList();
      return true;
    }
  }

  void insertDBShopList() async {
    final writeShopList =
        WriteShopList(name: textEditingControllerName.text.trim());
    DBShopList.insertShopList(writeShopList);
  }
}
