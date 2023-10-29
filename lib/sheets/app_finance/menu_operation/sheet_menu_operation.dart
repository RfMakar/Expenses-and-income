import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/app_finance/edit_operation/dialog_edit_operation.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/models/app_finance/operations.dart';
import 'package:budget/sheets/app_finance/menu_operation/provider_sheet_menu_operation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuOperation extends StatelessWidget {
  const SheetMenuOperation(
      {super.key, required this.operation, required this.finance});
  final Operation operation;
  final int finance;
  @override
  Widget build(BuildContext context) {
    void navigatorUpdateScreen() =>
        Navigator.pop(context, ActionsUpdate.updateScreen);
    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuOperation(operation, finance),
      child: Consumer<ProviderSheetMenuOperation>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.titleSheet(),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.subtitleSheet(),
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  const Divider(),
                ],
              ),
              ListTile(
                title: Text(provider.titleCategoty()),
                subtitle: const Text(
                  'Категория',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              ListTile(
                title: Text(provider.titleSubCategory()),
                subtitle: const Text(
                  'Подкатегория',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              ListTile(
                title: Text(provider.titleNote()),
                subtitle: const Text(
                  'Заметка',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Изменить'),
                onTap: () async {
                  final bool? result = await showDialog(
                      context: context,
                      builder: (context) =>
                          DialogEditOperation(operation: provider.operation));
                  if (result == true) {
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
                    provider.onTapDeletedOperation();
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
