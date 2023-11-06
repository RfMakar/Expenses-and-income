import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/sheets/app_finance/menu_subcategory/provider_sheet_menu_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuSubCategory extends StatelessWidget {
  const SheetMenuSubCategory({super.key, required this.subCategory});
  final SubCategory subCategory;

  @override
  Widget build(BuildContext context) {
    void navigatorUpdateWidget() => Navigator.pop(context, StateUpdate.widget);

    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuSubCategory(subCategory),
      child: Consumer<ProviderSheetMenuSubCategory>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                title: Text(provider.titleSheet()),
                subtitle: const Text(
                  'Подкатегория',
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
                        DialogEditName(name: provider.titleSheet()),
                  );
                  if (newName != null) {
                    provider.onTapRenamedSubCategory(newName);
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
                    builder: (context) => const DialodgDelete(),
                  );
                  if (result == true) {
                    provider.onTapDeletedSubCategory();
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
