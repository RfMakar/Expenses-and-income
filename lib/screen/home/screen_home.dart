import 'package:budget/const/actions_update.dart';
import 'package:budget/screen/add_finance/screen_add_finance.dart';
import 'package:budget/screen/category/screen_category.dart';
import 'package:budget/screen/home/provider_screen_home.dart';
import 'package:budget/screen/widget/drawer.dart';
import 'package:budget/screen/widget/switch_date.dart';
import 'package:budget/screen/widget/switch_finance.dart';
import 'package:budget/sheets/menu_operation/sheet_menu_operration.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenHome(),
      builder: (context, child) => Consumer<ProviderScreenHome>(
        builder: (context, provider, _) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenAddFinance(),
                  ),
                );
                provider.updateScreen();
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text(provider.titleAppBar()),
            ),
            drawer: const Drawer(child: WidgetDrawer()),
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
                    WidgetSwitchFinance(
                        isSelected: provider.isSelectedFinance,
                        onPressed: provider.onPressedButFinance),
                    const WidgetInfo(),
                    const WidgetListGroupCategory(),
                    const WidgetListHistoryAllOperation(),
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
    final provider = Provider.of<ProviderScreenHome>(context);
    return SwitchDate(
      onPressedCallBack: provider.onPressedSwitchDate,
      dateTime: provider.dateTime,
      value: provider.titleSumOperation(),
    );
  }
}

class WidgetListGroupCategory extends StatelessWidget {
  const WidgetListGroupCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenHome>(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          'Категории',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        provider.listGroupCategory.isEmpty
            ? const SizedBox(
                height: 60,
                child: Center(
                    child: Text('В этом месяце нет данных, нажмите "+".')),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: provider.listGroupCategory.length,
                itemBuilder: (context, index) {
                  return WidgetGroupCategory(
                    color: provider.colorGroupCategory(index),
                    name: provider.titleGroupCategory(index),
                    percent: provider.percentGroupCategory(index),
                    value: provider.valueGroupCategory(index),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenCategory(
                            finance: provider.finance,
                            dateTime: provider.dateTime,
                            groupCategory: provider.groupCategory(index),
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

class WidgetListHistoryAllOperation extends StatelessWidget {
  const WidgetListHistoryAllOperation({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenHome>(context);
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

class WidgetGroupCategory extends StatelessWidget {
  const WidgetGroupCategory({
    super.key,
    required this.color,
    required this.name,
    required this.percent,
    required this.value,
    required this.onTap,
  });
  final Color color;
  final String name;
  final double percent;
  final String value;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: color,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 3,
              offset: const Offset(0.5, 0.5), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //height: 50,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            CircularPercentIndicator(
              radius: 25.0,
              lineWidth: 4.0,
              percent: percent / 100,
              animation: true,
              center: Text(
                '$percent %',
                style: const TextStyle(fontSize: 10),
              ),
              progressColor: color,
            ),
            Container(
              // height: 25,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
