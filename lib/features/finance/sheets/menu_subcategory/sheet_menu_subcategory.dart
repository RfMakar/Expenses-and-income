import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/dialogs/delete/dialog_delete.dart';
import 'package:budget/features/app/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/features/finance/sheets/menu_subcategory/model_sheet_menu_subcategory.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelSheetMenuSubCategory>();
    void navigatorUpdateWidget() => Navigator.pop(context, StateUpdate.widget);
    return Wrap(
      children: [
        ListTile(
          title: Text(model.titleSheet()),
          subtitle: Text(
            localeApp.subcategory,
            style: const TextStyle(fontSize: 10),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: Text(localeApp.rename),
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
          title: Text(localeApp.delete),
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
