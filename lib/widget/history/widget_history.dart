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
      child: Consumer<ProviderWidgetHistory>(
        builder: (context, provider, child) {
          return Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'История операций',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ListView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.listHistoryOperation.length,
                itemBuilder: (context, indexHistory) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.titleHistoryOperation(indexHistory),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              provider.valueHistory(indexHistory),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.listOperation(indexHistory).length,
                        itemBuilder: (context, indexOperation) {
                          return InkWell(
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
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.titleOperation(
                                            indexHistory, indexOperation),
                                      ),
                                      Text(
                                        provider.trailingOperation(
                                          indexHistory,
                                          indexOperation,
                                        ),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.subtitlegOperation(
                                            indexHistory, indexOperation),
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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


/*


ListTile(
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
InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 8, 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                    ),
                    Text(value),
                  ],
                ),
              ),
              Text(
                  '$percent %',
                  style: const TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),

*/