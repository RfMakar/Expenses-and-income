import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/finance/sheets/menu_operation/sheet_menu_operation.dart';
import 'package:budget/features/finance/sheets/operation/sheet_operation.dart';
import 'package:budget/features/finance/widgets/history_operations/model_widget_history_operations.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WidgetHistoryOperations extends StatelessWidget {
  const WidgetHistoryOperations({
    super.key,
    required this.listHistoryOperation,
    required this.updateScreen,
  });
  final List<HistoryOperation> listHistoryOperation;
  final void Function() updateScreen;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ModelWidgetHistoryOperations(
        listHistoryOperation,
        updateScreen,
      ),
      child: const ViewWidget(),
    );
  }
}

class ViewWidget extends StatelessWidget {
  const ViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          localeApp.historyOfOperations,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const ListHistoryOperations(),
      ],
    );
  }
}

class ListHistoryOperations extends StatelessWidget {
  const ListHistoryOperations({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelWidgetHistoryOperations>();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: model.listHistoryOperation.length,
      itemBuilder: (context, indexHistory) {
        final operationHistory = model.listHistoryOperation[indexHistory];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localeApp
                        .dateHistory(DateTime.parse(operationHistory.date)),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    localeApp.valueFormatSimpleCurrency(operationHistory.value),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            ListOperations(
              listOperations:
                  model.listHistoryOperation[indexHistory].listOperation ?? [],
            ),
          ],
        );
      },
    );
  }
}

class ListOperations extends StatelessWidget {
  const ListOperations({super.key, required this.listOperations});
  final List<Operation> listOperations;
  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelWidgetHistoryOperations>();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listOperations.length,
      itemBuilder: (context, indexOperation) {
        final operation = listOperations[indexOperation];
        return InkWell(
          onTap: () async {
            final StateUpdate? actionsUpdate = await showModalBottomSheet(
              context: context,
              builder: (context) => SheetOperation(
                operation: operation,
              ),
            );
            if (actionsUpdate == StateUpdate.page) {
              model.updatePage();
            }
          },
          onLongPress: () async {
            final StateUpdate? actionsUpdate = await showModalBottomSheet(
              context: context,
              builder: (context) => SheetMenuOperation(
                operation: operation,
              ),
            );
            if (actionsUpdate == StateUpdate.page) {
              model.updatePage();
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        operation.nameCategory,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      localeApp.valueFormatSimpleCurrency(operation.value),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      operation.nameSubCategory,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
