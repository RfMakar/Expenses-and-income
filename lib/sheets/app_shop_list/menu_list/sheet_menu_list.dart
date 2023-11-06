import 'package:budget/const/actions_update.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/sheets/app_shop_list/menu_list/provider_menu_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuList extends StatelessWidget {
  const SheetMenuList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    void navigatorUpdateScreen() => Navigator.pop(context, StateUpdate.page);
    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuList(shopList),
      child: Consumer<ProviderSheetMenuList>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.check_box_outlined),
                title: const Text('Отметить все'),
                onTap: () {
                  provider.markTheList();
                  navigatorUpdateScreen();
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_box_outline_blank),
                title: const Text('Восстановить все'),
                onTap: () {
                  provider.restoreTheList();
                  navigatorUpdateScreen();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Удалить выбранные'),
                onTap: () {
                  provider.deleteSelected();
                  navigatorUpdateScreen();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever_outlined),
                title: const Text('Очистить список'),
                onTap: () {
                  provider.clearTheList();
                  navigatorUpdateScreen();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
