import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/model/subcategories.dart';
import 'package:budget/sheets/menu_subcategories/provider_sheet_menu_subcategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuSubCategories extends StatelessWidget {
  const SheetMenuSubCategories({super.key, required this.subCategories});
  final SubCategories subCategories;
  @override
  Widget build(BuildContext context) {
    void navigatorUpdateWidget() =>
        Navigator.pop(context, ActionsUpdate.updateWidget);
    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuSubCategories(subCategories),
      child: Consumer<ProviderSheetMenuSubCategories>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                title: Text(provider.nameSheet()),
                subtitle: const Text('Подкатегория'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Добавить операцию'),
                onTap: () async {
                  // final bool? update = await showDialog(
                  //   context: context,
                  //   builder: (context) =>
                  //       DialogAddSubCategories(categories: provider.categories),
                  // );
                  // if (update == true) {
                  //   navigatorUpdateWidget();
                  // }
                },
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
                    provider.onTapRenamedSubCategories(newName);
                    navigatorUpdateWidget();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Удалить'),
                onTap: () async {
                  final bool? result = await showDialog(
                    context: context,
                    builder: (context) =>
                        DialodgDelete(text: provider.nameSheet()),
                  );
                  if (result == true) {
                    provider.onTapDeletedSubCategories();
                    navigatorUpdateWidget();
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
