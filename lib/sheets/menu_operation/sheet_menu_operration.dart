import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/models/operations.dart';
import 'package:budget/sheets/menu_operation/provider_sheet_menu_operation.dart';
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
          return Wrap(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.titleSheet(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(provider.subtitleSheet())],
                  ),
                ],
              ),
              ListTile(
                title: Text(provider.titleCategoty()),
                subtitle: const Text('Категория'),
              ),
              ListTile(
                title: Text(provider.titleSubCategory()),
                subtitle: const Text('Подкатегория'),
              ),
              ListTile(
                title: Text(provider.titleNote()),
                subtitle: const Text('Заметка'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Изменить'),
                onTap: () async {
                  // final String? newNote = await showDialog(
                  //   context: context,
                  //   builder: (context) => DialogEditName(name: provider.note()),
                  // );
                  // if (newNote != null) {
                  //   provider.onTapRenameNote(newNote);
                  //   navigatorUpdateScreen();
                  // }
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
