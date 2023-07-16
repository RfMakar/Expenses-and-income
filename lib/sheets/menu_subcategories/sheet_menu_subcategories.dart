import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/add_operations/dialog_add_operations.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/sheets/menu_subcategories/provider_sheet_menu_subcategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuSubCategories extends StatelessWidget {
  const SheetMenuSubCategories(
      {super.key, required this.subCategories, required this.financeSwitch});
  final SubCategories subCategories;
  final int financeSwitch;
  @override
  Widget build(BuildContext context) {
    void navigatorUpdateWidget() =>
        Navigator.pop(context, ActionsUpdate.updateWidget);
    void navigatorPop() => Navigator.pop(context, ActionsUpdate.updateWidget);
    return ChangeNotifierProvider(
      create: (context) =>
          ProviderSheetMenuSubCategories(subCategories, financeSwitch),
      child: Consumer<ProviderSheetMenuSubCategories>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                title: Text(provider.titleSheet()),
                subtitle: const Text('Подкатегория'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.add),
                title: Text(provider.titleButtonAddFinace()),
                onTap: () async {
                  final bool? update = await showDialog(
                    context: context,
                    builder: (context) => DialogAddOperations(
                        subCategories: provider.subCategories),
                  );
                  if (update == true) {
                    navigatorPop();
                  }
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
                        DialogEditName(name: provider.titleSheet()),
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
                        DialodgDelete(text: provider.titleSheet()),
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
