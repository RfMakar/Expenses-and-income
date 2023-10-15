import 'package:budget/const/actions_update.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/screen/subcategory/provider_screen_subcategory.dart';
import 'package:budget/widget/switch_date.dart';
import 'package:budget/sheets/menu_operation/sheet_menu_operation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSubCategory extends StatelessWidget {
  const ScreenSubCategory({super.key, required this.groupSubCategory});

  final GroupSubCategory groupSubCategory;
  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenSubCategory(
          providerApp.finance.id, providerApp.switchDate, groupSubCategory),
      builder: (context, child) => Consumer<ProviderScreenSubCategory>(
          builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.titleAppBar()),
          ),
          body: FutureBuilder(
            future: provider.loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: [
                  const SizedBox(height: 4),
                  const WidgetInfo(),
                  provider.listHistoryOperation.isEmpty
                      ? SizedBox(
                          child: Center(
                              child: provider.switchDate.state == 0
                                  ? const Text('В этом месяце нет данных')
                                  : const SizedBox()),
                        )
                      : const WidgetListHistoryOperationSubCategory(),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenSubCategory>(context);
    return WidgetSwitchDate(
      titleValue: provider.titleSumOperation(),
      onPressedButBackDate: provider.onPressedButBackDate,
      onPressedButNextDate: provider.onPressedButNextDate,
    );
  }
}

class WidgetListHistoryOperationSubCategory extends StatelessWidget {
  const WidgetListHistoryOperationSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenSubCategory>(context);
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
                        provider.titleOperation(indexHistory, indexOperation),
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
                            finance: provider.finance,
                          ),
                        );
                        if (actionsUpdate == ActionsUpdate.updateScreen) {
                          provider.updateScreen();
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
  }
}
