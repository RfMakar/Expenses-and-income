import 'package:budget/const/actions_update.dart';
import 'package:budget/features/app/dialogs/delete/dialog_delete.dart';
import 'package:budget/features/app/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/features/finanse/sheets/menu_subcategory/model_sheet_menu_subcategory.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuSubCategory extends StatelessWidget {
  const SheetMenuSubCategory({super.key, required this.subCategory});
  final SubCategory subCategory;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelSheetMenuSubCategory(subCategory),
      child: const ViewSheet(),
    );
  }
}

class ViewSheet extends StatelessWidget {
  const ViewSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelSheetMenuSubCategory>();
    void navigatorUpdateWidget() => Navigator.pop(context, StateUpdate.widget);
    return Wrap(
      children: [
        ListTile(
          title: Text(model.titleSheet()),
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
                  DialogEditName(nameEdit: model.titleSheet()),
            );
            if (newName != null) {
              model.onTapRenamedSubCategory(newName);
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
              model.onTapDeletedSubCategory();
              navigatorUpdateWidget();
            }
          },
        ),
      ],
    );
  }
}
