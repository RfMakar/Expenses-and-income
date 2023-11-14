import 'package:budget/const/actions_update.dart';
import 'package:budget/features/finanse/sheets/menu_operation/sheet_menu_operation.dart';
import 'package:budget/features/finanse/sheets/operation/sheet_operation.dart';
import 'package:budget/features/finanse/widgets/history/provider_widget_history.dart';
import 'package:budget/model_app.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetHistory extends StatelessWidget {
  const WidgetHistory({
    super.key,
    required this.listHistoryOperation,
    required this.updateScreen,
  });
  final List<HistoryOperation> listHistoryOperation;
  final void Function() updateScreen;
  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ModelApp>(context);

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
                              final StateUpdate? actionsUpdate =
                                  await showModalBottomSheet(
                                context: context,
                                builder: (context) => SheetOperation(
                                  operation: provider.operation(
                                    indexHistory,
                                    indexOperation,
                                  ),
                                ),
                              );
                              if (actionsUpdate == StateUpdate.page) {
                                updateScreen();
                              }
                            },
                            onLongPress: () async {
                              final StateUpdate? actionsUpdate =
                                  await showModalBottomSheet(
                                context: context,
                                builder: (context) => SheetMenuOperation(
                                  operation: provider.operation(
                                    indexHistory,
                                    indexOperation,
                                  ),
                                ),
                              );
                              if (actionsUpdate == StateUpdate.page) {
                                updateScreen();
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
                                      Expanded(
                                        child: Text(
                                          provider.titleOperation(
                                              indexHistory, indexOperation),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        provider.trailingOperation(
                                          indexHistory,
                                          indexOperation,
                                        ),
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.subTitleOperation(
                                            indexHistory, indexOperation),
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
