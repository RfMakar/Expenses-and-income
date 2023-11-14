import 'package:budget/const/actions_update.dart';
import 'package:budget/features/app/dialogs/delete/dialog_delete.dart';
import 'package:budget/features/app/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/features/finanse/sheets/colors/sheet_colors.dart';
import 'package:budget/features/finanse/sheets/menu_category/model_sheet_menu.category.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuCategory extends StatelessWidget {
  const SheetMenuCategory({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelSheetMenuCategory(category),
      child: const ViewSheet(),
    );
  }
}

class ViewSheet extends StatelessWidget {
  const ViewSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelSheetMenuCategory>();
    void navigatorUpdatePage() => Navigator.pop(context, StateUpdate.page);
    void navigatorUpdateWidget() => Navigator.pop(context, StateUpdate.widget);
    return Wrap(
      children: [
        ListTile(
          title: Text(model.nameSheet()),
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
              builder: (context) => DialogEditName(nameEdit: model.nameSheet()),
            );
            if (newName != null) {
              model.onTapRenamedCategory(newName);
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
              model.onTapDeletedCategory();
              navigatorUpdatePage();
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
              model.onTapChangeColorCategory(newColor.value.toString());
              navigatorUpdateWidget();
            }
          },
        ),
      ],
    );
  }
}
