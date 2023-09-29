import 'package:budget/const/actions_update.dart';
import 'package:budget/models/categories.dart';
import 'package:budget/screen/category/provider_screen_category.dart';
import 'package:budget/screen/subcategory/screen_subcategory.dart';
import 'package:budget/screen/widget/switch_date.dart';
import 'package:budget/sheets/menu_operation/sheet_menu_operration.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory(
      {super.key,
      required this.finance,
      required this.dateTime,
      required this.groupCategory});
  final int finance;
  final DateTime dateTime;
  final GroupCategory groupCategory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ProviderScreenCategory(finance, dateTime, groupCategory),
      builder: (context, child) => Consumer<ProviderScreenCategory>(
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
                  children: const [
                    SizedBox(height: 4),
                    WidgetInfo(),
                    WidgetListGroupSubCategory(),
                    WidgetListHistoryOperationCategory(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenCategory>(context);
    return SwitchDate(
      onPressedCallBack: provider.onPressedSwitchDate,
      dateTime: provider.dateTime,
      value: provider.titleSumOperation(),
    );
  }
}

class WidgetListGroupSubCategory extends StatelessWidget {
  const WidgetListGroupSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenCategory>(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'Подкатегории',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        provider.listGroupSubCategory.isEmpty
            ? const SizedBox(
                height: 60,
                child: Center(child: Text('В этом месяце нет данных')),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.listGroupSubCategory.length,
                itemBuilder: (context, index) {
                  return WidgetGroupSubCategory(
                    name: provider.titleGroupSubCategory(index),
                    value: provider.valueGroupSubCategory(index),
                    percent: provider.percentGroupSubCategory(index),
                    color: provider.colorGroupSubCategory(index),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenSubCategory(
                            finance: provider.finance,
                            dateTime: provider.dateTime,
                            groupSubCategory: provider.groupSubCategory(index),
                          ),
                        ),
                      );
                      provider.updateScreen();
                    },
                  );
                },
              ),
      ],
    );
  }
}

class WidgetGroupSubCategory extends StatelessWidget {
  const WidgetGroupSubCategory({
    super.key,
    required this.name,
    required this.value,
    required this.percent,
    required this.color,
    required this.onTap,
  });
  final String name;
  final String value;
  final double percent;
  final Color color;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(name),
      trailing: Text(value, style: const TextStyle(fontSize: 14)),
      subtitle: LinearPercentIndicator(
        animation: true,
        lineHeight: 16.0,
        animationDuration: 500,
        percent: percent / 100,
        center: Text(
          '$percent %',
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
        barRadius: const Radius.circular(8),
        progressColor: color,
      ),
    );
  }
}

class WidgetListHistoryOperationCategory extends StatelessWidget {
  const WidgetListHistoryOperationCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenCategory>(context);
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