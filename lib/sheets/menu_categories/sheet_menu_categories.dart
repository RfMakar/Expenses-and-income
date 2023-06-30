import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/add_subcategories/dialog_add_subcategories.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/model/categories.dart';
import 'package:budget/sheets/colors/sheet_colors.dart';
import 'package:budget/sheets/menu_categories/provider_sheet_menu.categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuCategories extends StatelessWidget {
  const SheetMenuCategories({super.key, required this.categories});
  final Categories categories;
  @override
  Widget build(BuildContext context) {
    void navigatorUpdateScreen() =>
        Navigator.pop(context, ActionsUpdate.updateScreen);
    void navigatorUpdateWidget() =>
        Navigator.pop(context, ActionsUpdate.updateWidget);
    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuCategories(categories),
      child: Consumer<ProviderSheetMenuCategories>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                title: Text(provider.nameSheet()),
                subtitle: const Text('Категория'),
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
                    navigatorUpdateWidget();
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
                        DialogEditName(name: provider.nameSheet()),
                  );
                  if (newName != null) {
                    provider.onTapRenamedCategories(newName);
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
                    builder: (context) =>
                        DialodgDelete(text: provider.nameSheet()),
                  );
                  if (result == true) {
                    provider.onTapDeletedCategories();
                    navigatorUpdateScreen();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Изменить цвет'),
                onTap: () async {
                  final Color? newColor = await showModalBottomSheet(
                    context: context,
                    builder: (context) => const SheetColors(),
                  );
                  if (newColor != null) {
                    provider.onTapChangeColorCategories(newColor);
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
