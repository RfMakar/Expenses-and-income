import 'package:budget/screen2/add_finance/screen_add_finance.dart';
import 'package:budget/screen2/home/provider_screen_home.dart';
import 'package:budget/screen2/widget/switch_date.dart';
import 'package:budget/screen2/widget/switch_finance.dart';
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
                  provider.screenUpdate();
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                leading:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
                title: Column(
                  children: [
                    Text(
                      provider.titleAppBar(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    FutureBuilder(
                      future: provider.getSumOperations(),
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
                          provider.titleSumOperations(),
                          style: TextStyle(
                            color: provider.colorSumOperations(),
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
                  WidgetListGroupCategories(),
                  WidgetListHistoryOperations(),
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
            onPressedCallBack: provider.onPressedSwitchFinace,
          ),
          SwitchDate(onPressedCallBack: provider.onPressedSwitchDate),
        ],
      ),
    );
  }
}

class WidgetListGroupCategories extends StatelessWidget {
  const WidgetListGroupCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenHome>(context);
    return Column(
      children: [
        const Text(
          'Категории',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        FutureBuilder(
          future: provider.getListGroupCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            return provider.listGroupCategories.isEmpty
                ? const SizedBox(
                    height: 60,
                    width: 120,
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: provider.listGroupCategories.length,
                    itemBuilder: (context, index) {
                      return WidgetGroupCategories(
                        color: provider.colorGroupCategories(index),
                        name: provider.titleGroupCategories(index),
                        percent: provider.percentGroupCategories(index),
                        value: provider.valueGroupCategories(index),
                      );
                    },
                  );
          },
        ),
      ],
    );
  }
}

class WidgetListHistoryOperations extends StatelessWidget {
  const WidgetListHistoryOperations({super.key});

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
          future: provider.getListOperations(),
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
              itemCount: provider.listHistoryOperations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(provider.leadingHistory(index)),
                  title: Text(provider.titleHistory(index)),
                  subtitle: Text(provider.subtitleHistory(index)),
                  trailing: Text(provider.valueHistory(index)),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class WidgetGroupCategories extends StatelessWidget {
  const WidgetGroupCategories(
      {super.key,
      required this.color,
      required this.name,
      required this.percent,
      required this.value});
  final Color color;
  final String name;
  final double percent;
  final String value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 4.0,
              percent: percent / 100,
              animation: true,
              center: Text(
                '$percent %',
                style: const TextStyle(fontSize: 8),
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
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
