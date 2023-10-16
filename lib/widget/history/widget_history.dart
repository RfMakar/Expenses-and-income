import 'package:budget/const/actions_update.dart';
import 'package:budget/models/operations.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/sheets/menu_operation/sheet_menu_operation.dart';
import 'package:budget/widget/history/provider_widget_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetHistory extends StatelessWidget {
  const WidgetHistory({super.key, required this.listHistoryOperation});
  final List<HistoryOperation> listHistoryOperation;
  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);

    return ChangeNotifierProvider(
      create: (context) =>
          ProviderWidgetHistory(listHistoryOperation, providerApp.finance.id),
      builder: (context, child) => Consumer<ProviderWidgetHistory>(
        builder: (context, provider, child) {
          return Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'История операций',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.listHistoryOperation.length,
                itemBuilder: (context, indexHistory) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          provider.titleHistoryOperation(indexHistory),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          provider.valueHistory(indexHistory),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.listOperation(indexHistory).length,
                        itemBuilder: (context, indexOperation) {
                          return ListTile(
                            title: Text(
                              provider.titleOperation(
                                  indexHistory, indexOperation),
                            ),
                            subtitle: Text(
                              provider.subtitlegOperation(
                                  indexHistory, indexOperation),
                            ),
                            trailing: Text(
                              provider.trailingOperation(
                                  indexHistory, indexOperation),
                              style: const TextStyle(fontSize: 14),
                            ),
                            onTap: () async {
                              final ActionsUpdate? actionsUpdate =
                                  await showModalBottomSheet(
                                context: context,
                                builder: (context) => SheetMenuOperation(
                                  operation: provider.operation(
                                      indexHistory, indexOperation),
                                  finance: providerApp.finance.id,
                                ),
                              );
                              if (actionsUpdate == ActionsUpdate.updateScreen) {
                                providerApp.updateApp();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
