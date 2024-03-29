import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/dialogs/delete/dialog_delete.dart';
import 'package:budget/features/finance/dialogs/edit_operation/dialog_edit_operation.dart';
import 'package:budget/features/finance/sheets/menu_operation/model_sheet_menu_operation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuOperation extends StatelessWidget {
  const SheetMenuOperation({super.key, required this.operation});
  final Operation operation;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelSheetMenuOperation(
        operation,
      ),
      child: const ViewSheet(),
    );
  }
}

class ViewSheet extends StatelessWidget {
  const ViewSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelSheetMenuOperation>();
    void navigatorUpdateScreen() => Navigator.pop(context, StateUpdate.page);
    return Wrap(
      children: [
        ListTile(
          title: Text(model.titleSheet()),
          subtitle: Text(
            localeApp.dateTimeFormatOperationFrom(
                model.dateTime(), model.dateTime()),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: Text(localeApp.edit),
          onTap: () async {
            final StateUpdate? stateUpdate = await showDialog(
                context: context,
                builder: (context) =>
                    DialogEditOperation(operation: model.operation()));
            if (stateUpdate == StateUpdate.page) {
              navigatorUpdateScreen();
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
              model.onTapDeletedOperation();
              navigatorUpdateScreen();
            }
          },
        ),
      ],
    );
  }
}
