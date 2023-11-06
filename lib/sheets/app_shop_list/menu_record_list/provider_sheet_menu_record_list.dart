import 'package:budget/repositories/shop_list/models/record_list.dart';
import 'package:budget/repositories/shop_list/sqllite/db_shop_lists.dart';
import 'package:flutter/material.dart';

class ProviderSheetMenuRecordList extends ChangeNotifier {
  final RecordList recordList;
  ProviderSheetMenuRecordList(this.recordList);
  String nameSheet() {
    return recordList.name;
  }

  void onTapRenamedRecodList(String newName) async {
    await DBShopList.updateRecordListName(newName, recordList.id);
  }

  void onTapDeletedRecordList() async {
    await DBShopList.deleteRecordList(recordList.id);
  }
}
