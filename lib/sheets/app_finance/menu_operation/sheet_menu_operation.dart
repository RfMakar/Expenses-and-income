import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/app_finance/edit_operation/dialog_edit_operation.dart';
import 'package:budget/dialogs/delete/dialog_delete.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/sheets/app_finance/menu_operation/provider_sheet_menu_operation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuOperation extends StatelessWidget {
  const SheetMenuOperation({super.key, required this.operation});
  final Operation operation;
  @override
  Widget build(BuildContext context) {
    void navigatorUpdateScreen() => Navigator.pop(context, StateUpdate.page);
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) =>
          ProviderSheetMenuOperation(operation, providerApp.finance.id),
      child: Consumer<ProviderSheetMenuOperation>(
        builder: (context, provider, child) {
          return Wrap(
            children: [
              ListTile(
                title: Text(provider.titleSheet()),
                subtitle: Text(
                  provider.subTitleSheet(),
                  style: const TextStyle(fontSize: 12),
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
