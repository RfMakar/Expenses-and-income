import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:budget/sheets/app_shop_list/menu_shop_list/provider_sheet_menu_shop_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuShopList extends StatelessWidget {
  const SheetMenuShopList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    void navigatorUpdateScreen() =>
        Navigator.pop(context, ActionsUpdate.updateScreen);

    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuShopList(shopList),
      child: Consumer<ProviderSheetMenuShopList>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                title: Text(provider.nameSheet()),
                subtitle: const Text(
                  'Список',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Переименовать'),
                onTap: () async {
                  final String? newName = await showDialog(
                    context: context,
                    builder: (context) =>
                        DialogEditName(name: provider.nameSheet()),
                  );
                  if (newName != null) {
                    provider.onTapRenamedCategory(newName);
                    navigatorUpdateScreen();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Удалить'),
                onTap: () async {
                  final bool? result = await showDialog(
                    context: context,
                    builder: (context) => const DialodgDelete(),
                  );
                  if (result == true) {
                    provider.onTapDeletedShopList();
                    navigatorUpdateScreen();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
