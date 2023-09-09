import 'package:budget/const/actions_update.dart';
import 'package:budget/models/subcategories.dart';
import 'package:budget/screen2/subcategory/provider_screen_subcategory.dart';
import 'package:budget/screen2/widget/switch_date.dart';
import 'package:budget/sheets/menu_operation/sheet_menu_operration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSubCategory extends StatelessWidget {
  const ScreenSubCategory({
    super.key,
    required this.finance,
    required this.dateTime,
    required this.groupSubCategory,
  });
  final int finance;
  final DateTime dateTime;
  final GroupSubCategory groupSubCategory;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ProviderScreenSubCategory(finance, dateTime, groupSubCategory),
      builder: (context, child) => Consumer<ProviderScreenSubCategory>(
          builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Text(
                  provider.titleAppBar(),
                  style: const TextStyle(fontSize: 10),
                ),
                FutureBuilder(
                  future: provider.getSumOperationSubCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Text(
                      provider.titleSumOperatin(),
                      style: TextStyle(
                        color: provider.colorSumOperation(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: ListView(
            children: const [
              SizedBox(height: 4),
              WidgetInfo(),
              WidgetListHistoryOperationSubCategory(),
            ],
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
    return Card(
      child: Column(
        children: [
          SwitchDate(
            onPressedCallBack: provider.onPressedSwitchDate,
            dateTime: provider.dateTime,
          ),
        ],
      ),
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
        FutureBuilder(
          future: provider.getListHistoryOperationSubCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.listHistoryOperation.length,
              itemBuilder: (context, indexHistory) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        provider.titleHistoryOperation(indexHistory),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: provider.colorSumOperation(),
                        ),
                      ),
                      trailing: Text(
                        provider.valueHistory(indexHistory),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: provider.colorSumOperation(),
                            fontSize: 14),
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
            );
          },
        ),
      ],
    );
  }
}
