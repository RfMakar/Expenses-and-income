import 'package:budget/dialogs/add_subcategories/dialog_add_subcategories.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/model/categories.dart';
import 'package:budget/sheets/menu_categories/provider_sheet_menu.categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuCategories extends StatelessWidget {
  const SheetMenuCategories({super.key, required this.categories});
  final Categories categories;
  @override
  Widget build(BuildContext context) {
    void navigator() => Navigator.pop(context, true);
    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuCategories(categories),
      child: Consumer<ProviderSheetMenuCategories>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                iconColor: provider.colorCategories(),
                leading: const Icon(Icons.folder),
                title: Text(provider.nameSheet()),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Добавить подкатегорию'),
                onTap: () async {
                  final bool? update = await showDialog(
                    context: context,
                    builder: (context) =>
                        DialogAddSubCategories(categories: provider.categories),
                  );
                  if (update == true) {
                    navigator();
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Переименовать'),
                onTap: provider.onTapRenamedCategories,
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
                    provider.onTapDeletedCategories();
                    navigator();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Изменить цвет'),
                onTap: provider.onTapChangeColorCategories,
              ),
            ],
          );
        },
      ),
    );
  }
}
