import 'package:budget/const/actions_update.dart';
import 'package:budget/screen2/add_finance/screen_add_finance.dart';
import 'package:budget/screen2/category/screen_category.dart';
import 'package:budget/screen2/home/provider_screen_home.dart';
import 'package:budget/screen2/widget/switch_date.dart';
import 'package:budget/screen2/widget/switch_finance.dart';
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
                leading:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                title: Column(
                  children: [
                    Text(
                      provider.titleAppBar(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    FutureBuilder(
                      future: provider.getSumOperation(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                  WidgetInfo(),
                  WidgetListGroupCategory(),
                  WidgetListHistoryOperation(),
                ],
              ));
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
    return Card(
      child: Column(
        children: [
          WidgetSwitchFinance(
            onPressedCallBack: provider.onPressedSwitchFinance,
          ),
          SwitchDate(onPressedCallBack: provider.onPressedSwitchDate),
        ],
      ),
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
        FutureBuilder(
          future: provider.getListGroupCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }

            return provider.listGroupCategory.isEmpty
                ? const SizedBox(
                    height: 60,
                    child: Center(
                        child: Text('В этом месяце нет данных, нажмите "+".')),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                        },
                      );
                    },
                  );
          },
        ),
      ],
    );
  }
}

class WidgetListHistoryOperation extends StatelessWidget {
  const WidgetListHistoryOperation({super.key});

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
        FutureBuilder(
          future: provider.getListHistoryOperation(),
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
              height: 25,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
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
              height: 25,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
