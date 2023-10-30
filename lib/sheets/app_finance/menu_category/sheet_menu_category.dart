import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/models/app_finance/categories.dart';
import 'package:budget/sheets/app_finance/colors/sheet_colors.dart';
import 'package:budget/sheets/app_finance/menu_category/provider_sheet_menu.category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuCategory extends StatelessWidget {
  const SheetMenuCategory({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    void navigatorUpdateScreen() =>
        Navigator.pop(context, ActionsUpdate.updateScreen);
    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuCategory(category),
      child: Consumer<ProviderSheetMenuCategory>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                title: Text(provider.nameSheet()),
                subtitle: const Text(
                  'Категория',
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
                    provider.onTapDeletedCategory();
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
                    provider.onTapChangeColorCategory(newColor);
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
